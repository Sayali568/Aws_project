#!/bin/bash
set -euxo pipefail

dnf update -y
dnf install -y python3

mkdir -p /var/www/capstone
cat > /var/www/capstone/index.html <<'HTML'
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Capstone Cloud</title>
  <style>
    :root { color-scheme: dark; }
    body { margin: 0; min-height: 100vh; display: grid; place-items: center; font-family: Arial, sans-serif; background: #0d1b2a; color: #fff; }
    main { width: min(760px, calc(100% - 40px)); text-align: center; }
    .badge { display: inline-block; padding: 7px 12px; color: #f59d31; border: 1px solid rgba(245,157,49,.4); border-radius: 999px; font-size: 12px; letter-spacing: .12em; text-transform: uppercase; }
    h1 { margin: 20px 0 10px; font-size: clamp(38px, 8vw, 72px); }
    h1 span { color: #f59d31; }
    p { color: #b3c0cd; line-height: 1.7; }
    .stats { display: grid; grid-template-columns: repeat(3, 1fr); gap: 12px; margin-top: 28px; }
    .stat { padding: 18px; background: rgba(255,255,255,.04); border: 1px solid rgba(255,255,255,.08); border-radius: 10px; }
    .stat strong { display: block; color: #47b881; }
  </style>
</head>
<body>
  <main>
    <span class="badge">AWS Capstone · Healthy</span>
    <h1>Capstone<span>Cloud</span></h1>
    <p>A highly available web application served through an Application Load Balancer across multiple Availability Zones.</p>
    <div class="stats">
      <div class="stat"><strong>HTTP 200</strong>Application healthy</div>
      <div class="stat"><strong>2 AZ</strong>Cross-zone deployment</div>
      <div class="stat"><strong>ALB</strong>Traffic load balanced</div>
    </div>
  </main>
</body>
</html>
HTML

cat > /etc/systemd/system/capstone-web.service <<'UNIT'
[Unit]
Description=Capstone Cloud Web Application
After=network.target

[Service]
Type=simple
WorkingDirectory=/var/www/capstone
ExecStart=/usr/bin/python3 -m http.server 80 --bind 0.0.0.0
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
UNIT

systemctl daemon-reload
systemctl enable --now capstone-web
