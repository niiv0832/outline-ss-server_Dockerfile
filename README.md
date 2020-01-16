# outline-ss-server_Dockerfile
Docker for stand alone outline shadowsocks server (go lang)

Outline-ss-server is the shadowsocks implementation used by the Outline Server.

Main features:
Multiple users on a single port and multiple ports.
Whitebox monitoring of the service using prometheus.io
Live updates via config change + SIGHUP
Prohibits unsafe access to localhost ports and usage of non-AEAD ciphers

This Dockerfile create container with standalone version of outline-ss-server. 

Config example (config.yml):

````shell 
keys:
  - id: user-0
    port: 9000
    cipher: chacha20-ietf-poly1305
    secret: Secret0

  - id: user-1
    port: 9000
    cipher: chacha20-ietf-poly1305
    secret: Secret1

  - id: user-2
    port: 9001
    cipher: chacha20-ietf-poly1305
    secret: Secret2
````
