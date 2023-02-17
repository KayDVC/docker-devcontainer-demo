FROM python:alpine3.16
ARG USERNAME=NRuser
ARG REL_DIR=/home/${USERNAME}

# Requires root user perms.
RUN apk update
RUN apk add openssh
RUN apk add git

# Create and switch to non-Root User.
RUN mkdir ${REL_DIR}
RUN adduser --disabled-password -h ${REL_DIR} ${USERNAME} 
USER ${USERNAME}
WORKDIR ${REL_DIR}/flaskapp

# Update Package Management and Install Dependences
RUN pip install --upgrade pip
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy source files
COPY . .

# Grant RMW access to all files in Home Dir for NRuser.
USER root
RUN chown -R ${USERNAME} ${REL_DIR}

# Switch back to NRuser.
USER ${USERNAME}

EXPOSE 4001

ENTRYPOINT [ "cd" "./flaskapp" ]



