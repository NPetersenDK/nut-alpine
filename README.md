
# Docker NUT Server with Discord Notifications

A Docker container running Network UPS Tools (NUT) server with Discord Webhooks Support. This container allows you to monitor your UPS (Uninterruptible Power Supply) and receive events for various UPS events.

## Features
- NUT server running on Alpine Linux
- Discord notifications for UPS events
- USB UPS support
- Automatic permission handling
- Startup notification
- Configurable monitoring parameters

## Prerequisites
- Docker
- Docker Compose
- A USB UPS device
- A Discord webhook URL

## Quick Start

1. Clone the repository:
    ```bash
    git clone https://github.com/NPetersenDK/alpine-nut.git
    cd alpine-nut
    ```

2. Create a `.env` file with your email configuration:
    ```env
    DISCORD_WEBHOOK_URL=https://discord.com/api/webhooks/your-webhook-id/your-webhook-token
    ```

3. Start the container:
    ```bash
    docker-compose up -d
    ```

## Configuration

### Environment Variables

| Variable     | Description                             | Default                  |
|--------------|-----------------------------------------|--------------------------|
| DISCORD_WEBHOOK_URL  | URL for Discord Webhook | Non-Default, Required.   |

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

- DartSteven (DartSteven@icloud.com)
- NPetersenDK (git@nipetersen.dk)

## Support

For support, please open an issue on the GitHub repository.
