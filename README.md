# homey-assistant

Run Homey Self-Hosted Server as a Home Assistant add-on.

This add-on allows you to run [Homey Self-Hosted Server](https://homey.app) within your Home Assistant installation, providing a self-hosted alternative to the cloud-based Homey hub.

## Requirements

- Home Assistant (with Supervisor)
- Minimum 1 GB available RAM
- Minimum 1 GB available storage
- A dedicated LAN IP address for device discovery

**Important**: This add-on requires privileged mode and host networking to function properly, as Homey needs direct access to hardware (Z-Wave/ZigBee adapters) and the local network.

## Installation

1. Add this repository to your Home Assistant add-on store:
   - Go to **Settings** → **Add-ons** → **Add-on Store**
   - Click the three dots (⋮) in the top right corner
   - Select **Repositories**
   - Add this repository URL: `https://github.com/Doekse/homey-assistant`

2. Install the add-on:
   - Find **Homey Self-Hosted Server** in the add-on store
   - Click **Install**
   - Wait for the installation to complete

3. Start the add-on:
   - Click **Start** to launch the Homey Self-Hosted Server

## Configuration

The add-on uses host networking mode, which means Homey Self-Hosted Server will be accessible on your local network. The server should automatically be discoverable by the Homey mobile app.

No additional configuration is required by default. The add-on will persist its data automatically.

## Usage

After starting the add-on:

1. Open the Homey app on your iOS or Android device
2. Select **Add a new Homey**
3. Choose **Self-Hosted Server**
4. Follow the on-screen instructions to complete setup

## Architecture Support

This add-on supports the following architectures:
- `amd64` (Intel/AMD 64-bit)
- `arm64` (ARM 64-bit, e.g., Raspberry Pi 4)

## Technical Details

- **Docker Image**: `ghcr.io/athombv/homey-shs:latest`
- **Network Mode**: Host networking (required for device discovery)
- **Privileged Mode**: Enabled (required for hardware access)
- **Data Directory**: `/homey/user` (persisted automatically)

## Troubleshooting

- **Add-on won't start**: Check the logs in the Home Assistant add-on interface for error messages
- **Homey app can't discover server**: Ensure host networking is enabled and the add-on is running
- **Permission errors**: Verify that privileged mode is enabled in the add-on configuration

## Documentation

- [Home Assistant Add-on Development](https://developers.home-assistant.io/docs/add-ons)
- [Homey Self-Hosted Server Installation Guide](https://support.athom.com/en/support/solutions/articles/77000477194)

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Credits

This add-on is maintained by [Doekse](https://github.com/Doekse). Homey Self-Hosted Server is developed by [Athom B.V.](https://homey.app).
