# ১. বেস ইমেজ হিসেবে উবুন্টু ব্যবহার করা হচ্ছে
FROM ubuntu:22.04

# ইন্টারনাল প্রম্পট বন্ধ করার জন্য
ENV DEBIAN_FRONTEND=noninteractive

# ২. প্রয়োজনীয় প্যাকেজ, Apache, PHP, Python ইনস্টল করা
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
    && rm -rf /var/lib/apt/lists/*

# ৩. Node.js (Version 20) ইনস্টল করা
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# ৪. অ্যাপাচি কনফিগারেশন (পোর্ট ৮০ ডিফল্ট থাকে)
WORKDIR /var/www/html

# ৫. আপনার প্রোজেক্টের সব ফাইল (যেমন index.php বা index.html) কপি করা
COPY . .

# 🔴 অত্যন্ত গুরুত্বপূর্ণ: যদি আপনার রেপোজিটরিতে কোনো index.php বা index.html না থাকে, 
# তবে টেস্ট করার জন্য একটি ডিফল্ট index.php তৈরি করে নেওয়া হচ্ছে।
RUN echo "<?php echo '<h1>Server is running successfully with PHP, Node.js, Python!</h1>'; ?>" > /var/www/html/index.php

# ৬. পোর্ট ৮০ এক্সপোজ করা
EXPOSE 80

# ৭. Apache সার্ভার চালু করার ফাইনাল কমান্ড
CMD ["apachectl", "-D", "FOREGROUND"]
