FROM ubuntu:22.04

WORKDIR /lab

COPY README.md /lab

RUN <<EOF
apt update
apt install -y git cmake python3 g++ gcc ssh libpython3-dev  \
neovim unzip wget curl
echo "Asia/Shanghai" >> /etc/timezone
rm /etc/localtime
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
EOF

RUN <<EOF
apt install -y libeigen3-dev libopencv-dev ninja-build       \
mesa-utils libgl1-mesa-dev libglu1-mesa-dev libegl1-mesa-dev \
build-essential libx11-dev libeigen3-dev libepoxy-dev        \
libboost-all-dev openssl libssl-dev libwayland-dev           \
x11-apps konsole
EOF

RUN <<EOF
git clone --depth 1 --recursive https://github.com/stevenlovegrove/Pangolin.git
cd /lab/Pangolin
cmake -B build -G Ninja
cmake --build build --parallel $(nproc)
ninja -C build install
EOF

RUN <<EOF
wget https://github.com/UZ-SLAMLab/ORB_SLAM3/archive/refs/tags/v1.0-release.tar.gz -O ORB_SLAM3.tar.gz
tar -xvf /lab/ORB_SLAM3.tar.gz
rm /lab/ORB_SLAM3.tar.gz
EOF

RUN <<EOF
mv /lab/ORB_SLAM3-1.0-release /lab/ORB_SLAM3
cd /lab/ORB_SLAM3
sed -i "30a set(CMAKE_CXX_STANDARD 14)" CMakeLists.txt
sed -i "31a add_compile_options(--std=c++14)\n" CMakeLists.txt
chmod +x ./build.sh
./build.sh
EOF

RUN <<EOF
mkdir -p /lab/dataset/V103
cd /lab/dataset/V103
wget http://robotics.ethz.ch/~asl-datasets/ijrr_euroc_mav_dataset/vicon_room1/V1_03_difficult/V1_03_difficult.zip
unzip V1_03_difficult.zip
rm V1_03_difficult.zip
EOF

RUN <<EOF
touch /lab/run.sh
echo '#!/bin/bash
exec /lab/ORB_SLAM3/Examples/Monocular-Inertial/mono_inertial_euroc \
/lab/ORB_SLAM3/Vocabulary/ORBvoc.txt \
/lab/ORB_SLAM3/Examples/Monocular-Inertial/EuRoC.yaml \
/lab/dataset/V103 \
/lab/ORB_SLAM3/Examples/Monocular-Inertial/EuRoC_TimeStamps/V103.txt
' >> /lab/run.sh
chmod +x /lab/run.sh
EOF

RUN apt install -y libpango1.0-dev

RUN service ssh restart

EXPOSE 22 8888

CMD ["sleep", "infinity"]
