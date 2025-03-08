pipeline {
    agent any

    environment {
        SRC_DIR = "/tmp/packages"
        NODE_VERSION = "22.13.1"
        INSTALL_PATH = "/opt/zoho/nodejs22.13"
        TAR_OUTPUT = "/tmp/nodejs-${NODE_VERSION}.tar.gz"
        PYTHON_BIN = "/opt/zoho/python_3.12/bin/python3.12"
    }

    stages {
        stage('Install Dependencies') {
            steps {
                script {
                    sh """
                    sudo apt update && sudo apt install -y \
                    build-essential libssl-dev libbz2-dev \
                    libreadline-dev libsqlite3-dev curl \
                    zlib1g-dev libffi-dev liblzma-dev \
                    pkg-config python3-distutils python3-dev
                    """
                }
            }
        }

        stage('Extract Source') {
            steps {
                script {
                    sh """
                    cd ${SRC_DIR}
                    tar -xvf node-v${NODE_VERSION}.tar.gz
                    """
                }
            }
        }

        stage('Configure & Compile') {
            steps {
                script {
                    sh """
                    cd ${SRC_DIR}/node-v${NODE_VERSION}
                    
                    # Force correct Python version
                    export PATH=/opt/zoho/python_3.12/bin:\$PATH
                    export PYTHON=${PYTHON_BIN}

                    # Run configure
                    ${PYTHON_BIN} configure.py --prefix=${INSTALL_PATH} --enable-optimization
                    make -j\$(nproc)
                    """
                }
            }
        }

        stage('Package Compiled Binaries') {
            steps {
                script {
                    sh """
                    mkdir -p /tmp/nodejs-pack
                    cp -r ${SRC_DIR}/node-v${NODE_VERSION}/out/* /tmp/nodejs-pack
                    tar -czvf ${TAR_OUTPUT} -C /tmp/nodejs-pack .
                    """
                }
            }
        }
    }
}
