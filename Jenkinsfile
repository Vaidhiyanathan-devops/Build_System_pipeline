pipeline {
    agent any

    environment {
        SRC_DIR = "/tmp/packages"
        PYTHON_VERSION = "3.12.9"
        INSTALL_PATH = "/opt/zoho/Python_3.12"
        TAR_OUTPUT = "/tmp/python-${PYTHON_VERSION}.tar.gz"
    }

    stages {
        stage('Install Dependencies') {
            steps {
                script {
                    sh """
                    sudo apt update && sudo apt install -y \
                    build-essential libssl-dev libbz2-dev \
                    libreadline-dev libsqlite3-dev \
                    zlib1g-dev libffi-dev liblzma-dev
                    """
                }
            }
        }

        stage('Extract Source') {
            steps {
                script {
                    sh """
                    cd ${SRC_DIR}
                    tar -xvf Python-${PYTHON_VERSION}.tgz
                    """
                }
            }
        }

        stage('Configure & Compile') {
            steps {
                script {
                    sh """
                    cd ${SRC_DIR}/Python-${PYTHON_VERSION}
                    ./configure --prefix=${INSTALL_PATH} --enable-optimizations
                    make -j\$(nproc)
                    """
                }
            }
        }

        stage('Install Compiled Python') {
            steps {
                script {
                    sh """
                    cd ${SRC_DIR}/Python-${PYTHON_VERSION}
                    sudo make install
                    """
                }
            }
        }

        stage('Package Compiled Binaries') {
            steps {
                script {
                    sh """
                    mkdir -p /tmp/python-pack
                    sudo cp -r ${INSTALL_PATH}/* /tmp/python-pack
                    sudo tar -czvf ${TAR_OUTPUT} -C /tmp/python-pack .
                    """
                }
            }
        }
    }
}
