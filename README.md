<div>
    <h1>ORB-SLAM3-LAB</h1>
</div>

## Build

### Build By Podman

```bash
git clone --depth 1 https://github.com/SWUST-XKCV236/ORB_SLAM3_LAB.git
cd ORB_SLAM3_LAB
podman build -t orb_slam3_lab:22.04 .
```

### Build By Docker

```bash
git clone --depth 1 https://github.com/SWUST-XKCV236/ORB_SLAM3_LAB.git
cd ORB_SLAM3_LAB
docker build -t orb_slam3_lab:22.04 .
```

## Usage

### Podman

```bash
xhost +
podman run                                                 \
--name=orb_slam3_lab2                                      \
-e XDG_RUNTIME_DIR=/tmp                                    \
-e WAYLAND_DISPLAY=$WAYLAND_DISPLAY                        \
-v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/tmp/$WAYLAND_DISPLAY \
-e QT_QPA_PLATFORM=wayland                                 \
-e DISPLAY=$DISPLAY                                        \
-v /tmp/.X11-unix:/tmp/.X11-unix                           \
orb_slam3_lab:22.04
podman exec -it orb_slam3_lab /bin/bash
```

### Docker

```bash
xhost +
docker run                                                 \
--name=orb_slam3_lab2                                      \
-e XDG_RUNTIME_DIR=/tmp                                    \
-e WAYLAND_DISPLAY=$WAYLAND_DISPLAY                        \
-v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/tmp/$WAYLAND_DISPLAY \
-e QT_QPA_PLATFORM=wayland                                 \
-e DISPLAY=$DISPLAY                                        \
-v /tmp/.X11-unix:/tmp/.X11-unix                           \
orb_slam3_lab:22.04
docker exec -it orb_slam3_lab /bin/bash
```
