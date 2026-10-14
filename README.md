# Apex Sign

Self-hosted document filling and signing for [Apex Works](https://theapexworks.com), based in Monroe, WA.

Apex Sign is a fork of [DocuSeal](https://github.com/docusealco/docuseal) 3.3.2, rebranded for use at [sign.theapexworks.com](https://sign.theapexworks.com). DocuSeal is a trademark of DocuSeal LLC. This project does not present DocuSeal's name or logo as an Apex Works mark. Interactive pages keep a small "Powered by DocuSeal" credit, which the free edition requires.

Source code: https://github.com/damonjbrown-cloud/apex-sign

Questions: damon@theapexworks.com

## Deploy

Build the Docker image from this repository. Do not pull the upstream `docuseal/docuseal` image if you want the Apex Sign branding.

```sh
docker build -t apex-sign .
docker run --name apex-sign -p 3000:3000 -v .:/data apex-sign
```

By default the container uses SQLite. PostgreSQL or MySQL can be selected with the `DATABASE_URL` environment variable.

## License

Distributed under the AGPLv3 License with Section 7(b) Additional Terms. See [LICENSE](https://github.com/docusealco/docuseal/blob/master/LICENSE) and [LICENSE_ADDITIONAL_TERMS](https://github.com/docusealco/docuseal/blob/master/LICENSE_ADDITIONAL_TERMS) for more information.
Unless otherwise noted, all files © 2023-2026 DocuSeal LLC.
