
# Docker NUT Server with Email Notifications

A Docker container running Network UPS Tools (NUT) server with email notification support. This container allows you to monitor your UPS (Uninterruptible Power Supply) and receive email notifications for various UPS events.

## Features

- NUT server running on Alpine Linux
- Email notifications for UPS events
- USB UPS support
- Automatic permission handling
- SMTP support (including Gmail)
- Startup notification
- Configurable monitoring parameters

## Prerequisites

- Docker
- Docker Compose
- A USB UPS device
- SMTP server access (for notifications)

## Quick Start

1. Clone the repository:
    ```bash
    git clone https://github.com/DartSteven/alpine-nut.git
    cd alpine-nut
    ```

2. Create a `.env` file with your email configuration:
    ```env
    NOTIFY_FROM=your-email@example.com
    NOTIFY_TO=your-email@example.com
    SMTP_HOST=smtp.gmail.com
    SMTP_PORT=587
    SMTP_USER=your-email@gmail.com
    SMTP_PASS=your-app-specific-password
    SMTP_FROM=your-email@gmail.com
    ```

3. Start the container:
    ```bash
    docker-compose up -d
    ```

## Configuration

### Environment Variables

| Variable     | Description                             | Default                  |
|--------------|-----------------------------------------|--------------------------|
| NOTIFY_FROM  | Email address for sending notifications | your-email@example.com   |
| NOTIFY_TO    | Email address to receive notifications  | your-email@example.com   |
| SMTP_HOST    | SMTP server hostname                    | smtp.gmail.com           |
| SMTP_PORT    | SMTP server port                        | 587                      |
| SMTP_USER    | SMTP username                           | your-email@gmail.com     |
| SMTP_PASS    | SMTP password or app-specific password  | your-app-specific-password |
| SMTP_FROM    | Email address shown in From field       | your-email@gmail.com     |

### NUT Configuration

The NUT server is configured with the following default settings:
- Server port: 3493
- Admin user: `admin` (password: `adminpass`)
- Monitor user: `monuser` (password: `monpass`)

You can modify these settings in the following configuration files:
- `config/nut/ups.conf`: UPS device configuration
- `config/nut/upsd.conf`: NUT server configuration
- `config/nut/upsd.users`: User access configuration
- `config/nut/upsmon.conf`: UPS monitoring configuration

### Email Notifications

The container will send email notifications for the following UPS events:
- UPS Online
- UPS on Battery
- UPS Battery Low
- UPS Forced Shutdown
- UPS Communication Restored/Lost
- UPS Shutdown
- UPS Battery Replacement Needed

## Building the Image

To build the image locally:
```bash
docker-compose build --no-cache
```

## Ports

The container exposes port 3493 for NUT server communication.

## Volumes

The container uses the following device mapping:
- `/dev/bus/usb:/dev/bus/usb:rw` for USB UPS access

## Security

- All configuration files have appropriate permissions set
- The NUT server runs with limited privileges
- SSL/TLS is enabled for SMTP communication
- USB access is restricted to the NUT user

## Troubleshooting

1. Check container logs:
    ```bash
    docker-compose logs -f
    ```

2. Verify UPS connection:
    ```bash
    docker exec -it Nut-Server upsc ups@localhost
    ```

3. Test email notifications:
    ```bash
    docker exec -it Nut-Server /etc/nut/notifycmd.sh
    ```

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Network UPS Tools (NUT) project
- Alpine Linux team
- Docker community

## Author

DartSteven (DartSteven@icloud.com)

## Support

For support, please open an issue on the GitHub repository.
