FROM python:alpine3.16
ARG username=NRuser
ARG reldir=/home/${username}
ARG workdir=${reldir}/flaskapp

# Requires root user perms.
RUN apk update
RUN apk add openssh
RUN apk add git
RUN apk add doxygen

# Create and switch to non-Root User.
RUN mkdir ${reldir}
RUN adduser --disabled-password -h ${reldir} ${username} 
USER ${username}
WORKDIR ${workdir}

# Update Package Management and Install Dependences
RUN python3 -m venv ${reldir}/env
ENV PATH=${reldir}/env/bin:$PATH
RUN pip install --upgrade pip
COPY ./pythonfiles/requirements.txt .
RUN pip install -r requirements.txt

# Copy source files
COPY . .

# Grant RMW access to all files in Home Dir for NRuser.
USER root
RUN chown -R ${username} ${reldir}

# Switch back to NRuser.
USER ${username}

ENTRYPOINT [ "sh", "-c", "cd pythonfiles && flask run -h 0.0.0.0 -p 4001" ]

EXPOSE 4001


