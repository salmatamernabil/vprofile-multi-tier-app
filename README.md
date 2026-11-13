# VProfile – Multi-Tier Java Web Application

A multi-tier Java web application deployed in a virtualized Linux environment using Vagrant and VMware Workstation Player. This project demonstrates infrastructure provisioning, application deployment, database integration, web server configuration, and service communication.

## Project Overview

The VProfile application uses a multi-tier architecture with separate virtual machines for application services, database, messaging, caching, and web access.

The environment is provisioned and managed using Vagrant, with VMware Workstation Player as the virtualization provider.

## Architecture

| VM | Private IP | Role |
|---|---|---|
| web01 | 192.168.56.11 | Nginx Web Server |
| app01 | 192.168.56.12 | Apache Tomcat / Java Application |
| rmq01 | 192.168.56.13 | RabbitMQ Message Broker |
| mc01 | 192.168.56.14 | Memcached |
| db01 | 192.168.56.15 | MariaDB Database |

### Application Flow

1. Users access the application through the web tier.
2. Nginx handles incoming HTTP requests and forwards them to the application tier.
3. Tomcat runs the Java application.
4. The application communicates with MariaDB for persistent data.
5. RabbitMQ provides messaging services.
6. Memcached provides caching.

## Technologies Used

- **Vagrant** – Infrastructure provisioning and VM lifecycle management.
- **VMware Workstation Player** – Virtualization platform.
- **Linux** – Server operating system.
- **Java** – Application runtime.
- **Apache Tomcat** – Java application server.
- **Nginx** – Web server and reverse proxy.
- **MariaDB** – Relational database.
- **RabbitMQ** – Message broker.
- **Memcached** – In-memory caching.
- **Git & GitHub** – Version control and project management.
- **PowerShell** – Windows host management.

## Project Structure

```text
VProfile/
├── Vagrantfile
├── README.md
├── .gitignore
├── scripts/
│   ├── db01.sh
│   ├── app01.sh
│   ├── rmq01.sh
│   ├── mc01.sh
│   └── web01.sh
└── screenshots/
    ├── login.png
    ├── APP.png
```

*The structure above is illustrative; actual files may differ.*


## Deployment

### 1. Clone the repository

```bash
git clone https://github.com/salmatamernabil/vprofile-multi-tier-app.git
cd vprofile-multi-tier-app
```

### 2. Start the virtual machines

```bash
vagrant up --provider=vmware_desktop
```

### 3. Check VM status

```bash
vagrant status
```

### 4. Connect to a virtual machine

```bash
vagrant ssh app01
```

Other machines can be accessed using their Vagrant names:

```bash
vagrant ssh web01
vagrant ssh db01
vagrant ssh rmq01
vagrant ssh mc01
```

## Accessing the Application

After successful provisioning and deployment, access the application using the reachable IP address of the application or web tier, depending on your network configuration.

Example application URL:

```text
http://<APP01-IP>:8080/login
```

The application server's NAT IP may change after a VM restart.


## Author

**Salma Tamer**

GitHub: [@salmatamernabil](https://github.com/salmatamernabil)

---

*This project is part of my hands-on DevOps and cloud engineering learning journey.*
