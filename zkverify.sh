#!/bin/bash

# 从指定的 URL 下载并执行 logo.sh 脚本
curl -s https://raw.githubusercontent.com/ziqing888/logo.sh/main/logo.sh| bash
sleep 3

# 定义显示函数
show() {
    echo -e "\033[1;34m$1\033[0m"  # 使用蓝色输出文本
}

show "正在更新软件包列表并安装 Git..."
echo
sudo apt update  # 更新软件包列表
sudo apt install -y git  # 安装 Git
echo
show "正在安装 Node.js..."
# 下载并执行安装 Node.js 的脚本
wget -O - https://raw.githubusercontent.com/zunxbt/installation/main/node.sh | bash
echo
show "正在克隆 zkverify-proofverification 仓库..."
echo
git clone https://github.com/0xmetaschool/zkverify-proofverification.git  # 克隆指定的 GitHub 仓库
cd zkverify-proofverification  # 进入克隆的目录
echo
show "正在安装 snarkjs..."
echo
npm install -g snarkjs@latest  # 全局安装 snarkjs

echo
show "正在克隆 circom 仓库..."
echo
git clone https://github.com/iden3/circom.git  # 克隆 circom 仓库
cd circom  # 进入 circom 目录

echo
show "正在安装 circom..."
# 下载并执行安装 Rust 的脚本
source <(wget -O - https://raw.githubusercontent.com/zunxbt/installation/main/rust.sh)
cargo install --path circom  # 使用 Cargo 安装 circom
cd ..  # 返回上级目录

show "正在设置电路..."
echo
sudo chmod +x circuit_setup.sh  # 赋予 circuit_setup.sh 执行权限
./circuit_setup.sh  # 执行电路设置脚本

show "正在克隆 snarkjs2zkv 仓库..."
echo
git clone https://github.com/HorizenLabs/snarkjs2zkv.git  # 克隆 snarkjs2zkv 仓库
cd snarkjs2zkv  # 进入 snarkjs2zkv 目录

show "正在安装 snarkjs2zkv..."
echo
npm install  # 安装 snarkjs2zkv 的依赖

show "正在转换证明和验证密钥..."
# 执行转换证明和验证密钥的操作
node ../snarkjs2zkv convert-proof ../proof.json -o ../proof_zkv.json && \
node ../snarkjs2zkv convert-vk ../verification_key.json -o ../verification_key_zkv.json && \
node ../snarkjs2zkv convert-public ../public.json -o ../public_zkv.json -c bn128
