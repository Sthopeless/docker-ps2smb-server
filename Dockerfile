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
    
COPY smb.conf /etc/samba/smb.conf

RUN chmod u+r /etc/samba/smb.conf

EXPOSE 445

ENTRYPOINT smbd -F -S --no-process-group --debuglevel=$LOG_LEVEL
