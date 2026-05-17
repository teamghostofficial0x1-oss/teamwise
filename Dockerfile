# ১. বেস ইমেজ হিসেবে উবুন্টু ব্যবহার করা হচ্ছে
FROM ubuntu:22.04

# ইন্টারনাল প্রম্পট বন্ধ করার জন্য
ENV DEBIAN_FRONTEND=noninteractive

# ২. প্রয়োজনীয় প্যাকেজ, PHP, Python, OpenSSH Server এবং xrdp + GUI ইনস্টল করা
RUN apt-get update && apt-get install -y \
    curl \
    git \
    software-properties-common \
    php \
    python3 \
    python3-pip \
    python3-venv \
    openssh-server \
    sudo \
    xrdp \
    xfce4 \
    xfce4-goodies \
    && rm -rf /var/lib/apt/lists/*

# ৩. Node.js (Version 20) ইনস্টল করা
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# ৪. SSH কনফিগারেশন (পোর্ট ২২ থেকে ৮০-তে পরিবর্তন এবং পাসওয়ার্ড অথেনটিকেশন অন)
RUN mkdir /var/run/sshd && \
    sed -i 's/#Port 22/Port 80/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# ৫. xrdp কনফিগারেশন করা (যাতে xfce ডেস্কটপ এনভায়রনমেন্ট লোড হয়)
RUN echo "xfce4-session" > /etc/skel/.Xclients && \
    cp /etc/skel/.Xclients /root/.Xclients && \
    sed -i 's/3389/80/g' /etc/xrdp/xrdp.ini

# ৬. ইউজারনেম ও পাসওয়ার্ড সেট করা
# ইউজারনেম: dev এবং পাসওয়ার্ড: pass1234 (SSH এবং RDP দুটোর জন্যই এক)
RUN useradd -rm -d /home/dev -s /bin/bash -g root -G sudo -u 1000 dev && \
    echo 'rubel:rubel@@@@' | chpasswd && \
    echo 'root:rubel@@@@' | chpasswd && \
    cp /etc/skel/.Xclients /home/dev/.Xclients && \
    chown -R dev:root /home/dev

# ৭. ওয়ার্কিং ডিরেক্টরি সেট করা
WORKDIR /home/dev
COPY . .

# ৮. Render-এর জন্য পোর্ট ৮০ এক্সপোজ করা
EXPOSE 80

# ৯. একটি স্টার্টআপ স্ক্রিপ্ট তৈরি করা যাতে SSH এবং xrdp একসাথে ব্যাকগ্রাউন্ডে চলে
RUN echo '#!/bin/bash\n\
service ssh start\n\
service xrdp start\n\
tail -f /dev/null' > /start.sh && chmod +x /start.sh

# ফাইনাল কমান্ড রান করা
CMD ["/start.sh"]
