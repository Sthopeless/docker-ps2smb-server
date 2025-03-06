FROM dperson/samba

ARG UID=1000
ARG GID=1001
ARG LOG_LEVEL=1

RUN addgroup -S -g $GID "user"

RUN adduser -S -D -H -h /tmp \
            -s /sbin/nologin \
            -G user -g User \
            -u $UID user

RUN smbpasswd -s -a -n "user"

RUN echo "[global]\n\
    socket options = TCP_NODELAY TCP_KEEPIDLE=20 IPTOS_LOWDELAY SO_KEEPALIVE\n\
    getwd cache = yes\n\
    large readwrite = yes\n\
    aio read size = 0\n\
    aio write size = 0\n\
    strict locking = no\n\
    follow symlinks = yes\n\
    ntlm auth = yes\n\
    lanman auth = yes\n\
    log level = 3\n\
    client min protocol = CORE\n\
    client max protocol = NT1\n\
    server max protocol = SMB3\n\
    server min protocol = NT1\n\
    strict sync = no\n\
    keepalive = 0\n\
    map to guest = bad user\n\
    allow insecure wide links = yes\n\
\n\
[PS2SMB]\n\
    comment = PS2SMB\n\
    path = /mount\n\
    read only = no\n\
    Browseable = yes\n\
    Writeable = Yes\n\
    only guest = no\n\
    create mask = 0777\n\
    directory mask = 0777\n\
    Public = yes\n\
    Guest ok = yes\n\
    force user = user\n\
    follow symlinks = yes\n\
    wide links = yes" > /etc/samba/smb.conf
    
# COPY smb.conf /etc/samba/smb.conf
RUN chmod u+r /etc/samba/smb.conf

EXPOSE 445

ENTRYPOINT smbd -F -S --no-process-group --debuglevel=$LOG_LEVEL
