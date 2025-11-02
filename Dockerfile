# 1. Using a 'latest' tag (CIS-DI-0005: Avoid 'latest' tag)
# 2. Using an EOL (End of Life) base image (ubuntu:20.04 is EOL in Apr 2025)
FROM ubuntu:20.04

# 3. Storing secrets in LABEL (CIS-DI-0004: Do not store secrets in LABEL)
LABEL maintainer="admin@example.com" \
      password="mypassword123"

# 4. Storing secrets in ENV (CIS-DI-0003: Do not store secrets in ENV)
ENV API_KEY="sk_live_12345abcdeFGHIjklmNOPqrst"
ENV DATABASE_PASSWORD="super_secret_db_pass!"

# 5. Using 'ADD' with a remote URL (CIS-DI-0006: Avoid 'ADD' command with remote URLs)
ADD http://example.com/config.conf /etc/config.conf

# 6. Using 'ADD' instead of 'COPY' for local files (CIS-DI-0010: Use 'COPY' instead of 'ADD')
ADD . /app

# 7. Updating/installing in separate layers, not cleaning cache
#    (CIS-DI-0007: Consolidate 'RUN' instructions)
#    (DKL-DI-0003: Clear package manager cache)
RUN apt-get update
RUN apt-get install -y sudo ssh vim curl
RUN apt-get upgrade -y # (DKL-DI-0002: Do not use 'upgrade')

# 8. Installing 'sudo' (DKL-DI-0001: Do not use 'sudo')
# 9. Installing 'ssh' and exposing port 22 (CIS-DI-0008: Do not expose SSH)
EXPOSE 22
EXPOSE 80

# 10. Creating a private key inside the image (DKL-DI-0008: Do not store private keys)
RUN mkdir -p /root/.ssh/
RUN echo "-----BEGIN RSA PRIVATE KEY-----\n...key_data...\n-----END RSA PRIVATE KEY-----" > /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

# 11. No HEALTHCHECK instruction (CIS-DI-0009: Add 'HEALTHCHECK')
# ... (No HEALTHCHECK provided) ...

# 12. Running as the default 'root' user
#     (CIS-DI-0001: Create a non-root user)
# 13. Setting a default command that runs as root
CMD ["/usr/sbin/sshd", "-D"]
