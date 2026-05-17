# ১. বেস ইমেজ হিসেবে উবুন্টু ব্যবহার করা হচ্ছে
FROM ubuntu:22.04

# ইন্টারনাল প্রম্পট বন্ধ করার জন্য
ENV DEBIAN_FRONTEND=noninteractive

# ২. প্রয়োজনীয় সিস্টেম প্যাকেজ, Apache, PHP এবং SSH-এর জন্য curl/ca-certificates ইনস্টল করা
RUN apt-get update && apt-get install -y \
    curl \
    git \
    software-properties-common \
    apache2 \
    php \
    libapache2-mod-php \
    python3 \
    python3-pip \
    python3-venv \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# ৩. Node.js (Version 20) ইনস্টল করা
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# ৪. কাজের সুবিধার্থে ওয়ার্কিং ডিরেক্টরি সেট করা
WORKDIR /var/www/html

# ৫. আপনার প্রোজেক্টের সব ফাইল ডকার কন্টেইনারে কপি করা
COPY . .

# ৬. Apache-এর ডিফল্ট পোর্ট ৮০ ওপেন করা
EXPOSE 80

# ৭. সার্ভার চালু করার কমান্ড (Apache ব্যাকগ্রাউন্ডে চলবে)
CMD ["apachectl", "-D", "FOREGROUND"]
