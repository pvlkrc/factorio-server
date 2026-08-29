# Factorio Server

Headless Factorio dedicated server, packaged as a Docker image and run via `docker-compose`.

## Requirements

- Docker
- Docker Compose

## Step-by-step setup

Starting from nothing but this repo's config files (e.g. deploying on a fresh machine):

Can be run on ARM64 machines, but this system must have QEMU for x86_64 binaries enabled:

docker run --rm --privileged tonistiigi/binfmt --install all



1. **Create a folder for the server** and put these three files from this repo into it:
   - `docker-compose.yml`
   - `server-settings.json`
   - `mod-list.json`

2. **Edit `server-settings.json`** — at least set `name`, `description`, and `game_password` to what you want. See [Changing settings](#changing-settings) below.

3. **(Optional) Bring an existing save** — if you already have a save from elsewhere and want to keep playing it instead of starting fresh:
   - create a `saves/` folder next to `docker-compose.yml`
   - copy your save file into it and **rename it to exactly `save.zip`** — the server only looks for that name, and if it's missing it will generate a brand new map instead.

4. **Start the server:**
   ```
   docker compose up -d
   ```
   If you skipped step 3, the container creates a new map (`saves/save.zip`) on this first start. On every start after that it reuses whatever is already in `saves/`, so it won't overwrite your world.

5. **Check that it's running:**
   ```
   docker compose logs -f
   ```
   Look for `Hosting game at ...` in the log.

## Quick start

Once the three files above are in place and configured, day-to-day usage is just:

```
docker compose up -d
```

Check that it's running:

```
docker compose logs -f
```

Stop it:

```
docker compose down
```

## Files

| File | Purpose |
|---|---|
| `docker-compose.yml` | Defines the service, ports, and volume mounts. |
| `server-settings.json` | Server config (name, description, password, visibility, etc.). Mounted into the container, edit and restart the container to apply. |
| `mod-list.json` | Which mods are enabled. `base` must stay `true`; `elevated-rails`, `quality`, and `space-age` are disabled by default. Mounted into the container. |
| `saves/` | Persisted save games on the host, mounted into the container so the world survives container restarts/recreation. |

## Changing settings

1. Edit `server-settings.json` (name, password, visibility, ...) and/or `mod-list.json` (enabled mods).
2. Restart the container:
   ```
   docker compose restart
   ```

**Note on mods:** a save file remembers which mods were active when it was created. If you change `mod-list.json` after a save already exists, delete `saves/save.zip` so the server generates a fresh one with the new mod set — otherwise you may get a mismatch/migration warning.

## Ports

| Port | Protocol | Purpose |
|---|---|---|
| 34197 | UDP | Main game port |
| 34196 | UDP | Additional server port |

## Image

The image is built and published by [.github/workflows/deploy.yml](.github/workflows/deploy.yml) to `ghcr.io/pvlkrc/factorio-server`. To build and run it locally instead of pulling from the registry:

```
docker build --build-arg VER=$(cat VERSION) -t ci_factorio .
```

and point `image:` in `docker-compose.yml` to `ci_factorio` instead.
