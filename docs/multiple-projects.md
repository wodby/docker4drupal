To use D4D with multiple projects simply adjust the ports in the compose file, e.g. instead of ports 8000, 8001, 8002 you can use 7000, 7001, 7002.

If you [use domains](domains.md), you don't have options other than to keep only one instance of docker-compose and stop others. Alternatively, Linux users can move out traefik container and run it separately (this won't work for macOS).
