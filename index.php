<?php
// সার্ভারের কিছু লাইভ ডাটা রিড করা (হাই পাওয়ার মেকানিজম ভাইব দেওয়ার জন্য)
$server_ip = $_SERVER['SERVER_ADDR'] ?? '127.0.0.1';
$user_ip = $_SERVER['REMOTE_ADDR'] ?? 'Unknown';
$php_version = phpversion();
$server_software = $_SERVER['SERVER_SOFTWARE'] ?? 'Apache/Ubuntu';
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TeamBDCyberNinja | Server Live</title>
    <style>
        * {
            box-sizing: border-box;
        }
        body {
            background-color: #020202;
            color: #00ff33;
            font-family: 'Courier New', Courier, monospace;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .terminal {
            background-color: rgba(5, 5, 5, 0.95);
            border: 2px solid #00ff33;
            width: 100%;
            max-width: 800px;
            box-shadow: 0 0 30px rgba(0, 255, 51, 0.2);
            border-radius: 6px;
            overflow: hidden;
        }
        .terminal-header {
            background-color: #222;
            padding: 10px;
            border-bottom: 2px solid #00ff33;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .buttons {
            display: flex;
            gap: 8px;
        }
        .btn {
            width: 12px;
            height: 12px;
            border-radius: 50%;
        }
        .btn-red { background-color: #ff5f56; }
        .btn-yellow { background-color: #ffbd2e; }
        .btn-green { background-color: #27c93f; }
        .title {
            color: #aaa;
            font-size: 14px;
            font-weight: bold;
        }
        .terminal-body {
            padding: 25px;
            line-height: 1.6;
        }
        .glitch-text {
            font-size: 24px;
            text-align: center;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 3px;
            margin-bottom: 25px;
            text-shadow: 0 0 10px #00ff33;
        }
        .status-box {
            border: 1px dashed #00ff33;
            padding: 15px;
            background: rgba(0, 40, 0, 0.1);
            margin-bottom: 20px;
        }
        .pulse {
            display: inline-block;
            width: 10px;
            height: 10px;
            background-color: #00ff33;
            border-radius: 50%;
            box-shadow: 0 0 10px #00ff33;
            animation: blink 1s infinite;
        }
        .logs {
            color: #888;
            font-size: 14px;
        }
        .success { color: #00ff33; font-weight: bold;}
        .warning { color: #ffcc00; }
        
        @keyframes blink {
            50% { opacity: 0; }
        }
    </style>
</head>
<body>

    <div class="terminal">
        <div class="terminal-header">
            <div class="buttons">
                <div class="btn btn-red"></div>
                <div class="btn btn-yellow"></div>
                <div class="btn btn-green"></div>
            </div>
            <div class="title">root@teambdcyberninja:~</div>
            <div></div>
        </div>

        <div class="terminal-body">
            <div class="glitch-text">>> TeamBDCyberNinja <<</div>
            
            <div class="status-box">
                <span class="pulse"></span> <strong>CORE SYSTEM OVERVIEW:</strong><br>
                [+] STATUS: <span class="success">ONLINE & BYPASSING REGULAR CODES</span><br>
                [+] HIGH POWER MECHANISM: <span class="success">ACTIVATED (100%)</span>
            </div>

            <div class="logs">
                <p>[<span class="warning">INFO</span>] Initializing PHP secure back-end components...</p>
                <p>[<span class="success">OK</span>] Server Software detected: <?php echo htmlspecialchars($server_software); ?></p>
                <p>[<span class="success">OK</span>] PHP Engine Version: <?php echo htmlspecialchars($php_version); ?></p>
                <p>[<span class="success">OK</span>] Host Nodes established at IP: <?php echo htmlspecialchars($server_ip); ?></p>
                <p>[<span class="warning">SEC</span>] Your Access IP tracked: <?php echo htmlspecialchars($user_ip); ?></p>
                <p style="color: #00ff33; margin-top: 20px;">root@teambdcyberninja:~# <span style="color: #fff; animation: blink 0.8s infinite;">_</span></p>
            </div>
        </div>
    </div>

</body>
</html>
