pipeline {
    agent any

    environment {
        SRC_DIR = "/tmp/packages"
        PYTHON_VERSION = "3.12.9"
        INSTALL_PATH = "/opt/zoho/Python_3.12"
        TAR_OUTPUT = "/tmp/python-${PYTHON_VERSION}.tar.gz"
    }

    stages {
        stage('Cleanup Previous Build') {
            steps {
                script {
                    sh """
                    echo "Cleaning previous build..."
                    sudo rm -rf "${env.INSTALL_PATH}" "${env.TAR_OUTPUT}" /tmp/python-pack
                    sudo rm -rf "${env.SRC_DIR}/Python-${env.PYTHON_VERSION}"
                    """
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    sh """
                    sudo apt install -y \
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
                    cd "${env.SRC_DIR}"
                    tar -xvf Python-${env.PYTHON_VERSION}.tgz
                    """
                }
            }
        }

        stage('Configure & Compile') {
            steps {
                script {
                    sh """
                    cd "${env.SRC_DIR}/Python-${env.PYTHON_VERSION}"
                    ./configure --prefix="${env.INSTALL_PATH}" --enable-optimizations
                    make -j\$(nproc)
                    """
                }
            }
        }

        stage('Install Compiled Python') {
            steps {
                script {
                    sh """
                    cd "${env.SRC_DIR}/Python-${env.PYTHON_VERSION}"
                    make install
                    """
                }
            }
        }

        stage('Package Compiled Binaries') {
            steps {
                script {
                    sh """
                    mkdir -p /tmp/python-pack
                    cp -r "${env.INSTALL_PATH}"/* /tmp/python-pack
                    tar -czvf "${env.TAR_OUTPUT}" -C /tmp/python-pack .
                    """
                }
            }
        }
    }
}
