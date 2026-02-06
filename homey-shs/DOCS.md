# Home Assistant Community Add-on: Homey Self-Hosted Server

This add-on allows you to run [Homey Self-Hosted Server](https://homey.app) within your Home Assistant OS installation, providing a self-hosted alternative to the cloud-based Homey hub.

Homey Self-Hosted Server is a software-only product based on the operating system powering [Homey Pro](https://homey.app/homey-pro/). You host Homey Self-Hosted Server yourself, on your own hardware. You'll need to install and maintain it to keep it online and up to date.

Out of the box, it supports devices that connect over Wi-Fi, Ethernet, Cloud, and Matter. Matter-over-Thread also works if you already have a Thread Border Router in your home. To add Zigbee, Z-Wave, Bluetooth LE, 433 MHz, or Infrared devices, simply connect a [Homey Bridge](https://homey.app/homey-bridge/) to unlock those wireless technologies — no USB sticks required.

## Installation

The installation of this add-on is pretty straightforward and not different in
comparison to installing any other Home Assistant add-on.

1. Click the Home Assistant My button below to open the add-on on your Home
   Assistant instance.

   [![Open this add-on in your Home Assistant instance.][addon-badge]][addon]

   **Note**: If Home Assistant can't find the add-on after adding the repository,
   try the following:
   - Go to **Settings** > **Add-ons** > **Add-on Store**
   - Click the three-dot menu (⋮) in the top-right corner
   - Select **Reload** to refresh the add-on store
   - The add-on should then appear in the store

2. Click the "Install" button to install the add-on.
3. Start the "Homey Self-Hosted Server" add-on.
4. Enjoy the add-on!

After starting the add-on:

1. Open the Homey app on your iOS or Android device
2. Select **Add a new Homey**
3. Choose **Self-Hosted Server**
4. Follow the on-screen instructions to complete setup

## Configuration

**Note**: _Remember to restart the add-on when the configuration is changed._

Currently, this add-on does not require any additional configuration. The add-on uses host networking mode by default, which means Homey Self-Hosted Server will be accessible on your local network. The server should automatically be discoverable by the Homey mobile app.

The add-on persists its data automatically in the `/addon_configs` directory (specifically `/addon_configs/homey-shs` or similar depending on the add-on slug).

### Backups & SSH Access

By storing data in `/addon_configs`, the Homey user data (`/homey/user`) becomes easily accessible via the official **Terminal & SSH** add-on for Home Assistant.

This facilitates manual backups and data management. You can access your Homey data at:
- Host path: `/addon_configs/<addon_slug>/`
- Internal container path: `/config`

This allows you to easily backup your Homey data using standard Linux tools from the SSH terminal.

### Web UI Access

**Important**: Before accessing the web UI, you must first set up Homey Self-Hosted Server via the mobile app (see the [Installation](#installation) section above). After the initial setup, you need to create a local user to access the web UI. Detailed instructions for creating local users can be found in the [Homey support documentation](https://support.homey.app/hc/en-us/articles/22924537226268-Using-Local-Users-on-Homey-Pro).

Once a local user has been created, access the Homey Self-Hosted Server web UI directly at `http://[HOST]:4859` where `[HOST]` is your Home Assistant host's IP address or hostname. You can also use the "Open web UI" button in the Home Assistant interface.

### Technical Details

- **Docker Image**: `ghcr.io/athombv/homey-shs:latest`
- **Network Mode**: Host networking (required for device discovery)
- **Privileged Mode**: Enabled (Homey Self-Hosted Server expects to run in Privileged mode)
- **Data Directory**: `/addon_configs` (mapped to `/config` internally)
- **Web UI**: Accessible at `http://[HOST]:4859` when the add-on is running
- **Ingress**: Not supported (incompatible with host networking required for device discovery)
### Ports

Homey Self-Hosted Server uses the following ports by default:
- HTTP: 4859
- HTTPS: 4860
- Bridge V1: 4861
- Bridge V2: 4862

Since the add-on uses host networking, these ports are directly accessible on your local network.

## Licensing

Every new installation of Homey Self-Hosted Server includes a 30-day free trial, with no payment details required.

After the trial, you can continue using Homey Self-Hosted Server by subscribing monthly or purchasing a lifetime license — helping support the ongoing development of Homey.

Self-Hosted Servers and licenses can be managed at the [My Self-Hosted Servers](https://homey.app/account/self-hosted-servers/) page on the Homey website.

### Monthly Subscription

Once you've set up your Homey Self-Hosted Server, you can start a monthly subscription from the [My Self-Hosted Servers](https://homey.app/account/self-hosted-servers/) page.

**Important**: If your monthly subscription expires, your Homey Self-Hosted Server will automatically go offline until you resubscribe or purchase a lifetime license.

### Lifetime License

Once you've set up your Homey Self-Hosted Server, you can buy a lifetime license from the [My Self-Hosted Servers](https://homey.app/account/self-hosted-servers/) page.

You can transfer your lifetime license between installations from the self-hosted servers management page.

## Known issues and limitations

- This add-on requires Home Assistant OS or Home Assistant Supervised (add-ons are not available on Home Assistant Core or Container installations).
- The add-on requires privileged mode and host networking to function properly.
- Minimum 1 GB available RAM and 1 GB available storage is recommended.
- A dedicated LAN IP address is required for discovery.

## Support

Got questions?

You have several options to get them answered:

- The Homey [Community Forum][forum]
- The Homey [Community Slack][slack]

You can also [open an issue here][issue] on GitHub

## Authors & contributors

The original setup of this repository is by [Doekse][doekse].

For a full list of all authors and contributors,
check [the contributor's page][contributors].

Homey Self-Hosted Server is developed by [Athom B.V.](https://homey.app).

## License

MIT License

Copyright (c) 2025 Doekse

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[addon-badge]: https://my.home-assistant.io/badges/supervisor_addon.svg
[addon]: https://my.home-assistant.io/redirect/supervisor_addon/?addon=f25c90cb_homey-shs&repository_url=https%3A%2F%2Fgithub.com%2FDoekse%2Faddon-homeyshs
[contributors]: https://github.com/Doekse/addon-homeyshs/graphs/contributors
[doekse]: https://github.com/Doekse
[forum]: https://community.homey.app
[issue]: https://github.com/Doekse/addon-homeyshs/issues
[slack]: https://slack.athom.com
