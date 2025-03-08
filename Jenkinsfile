pipeline {
    agent any

    environment {
        SRC_DIR = "/tmp/packages"
        NODE_VERSION = "22.13.1"
        INSTALL_PATH = "/opt/zoho/nodejs22.13"
        TAR_OUTPUT = "/tmp/nodejs-${NODE_VERSION}.tar.gz"
        GITHUB_REPO = "https://github.com/Vaidhiyanathan-devops/Jenkins_test.git"
        GIT_BRANCH = "main"
        PYTHON_BIN = "/opt/zoho/python_3.12/bin/python3.12"
    }

    stages {
        stage('Install Dependencies') {
            steps {
                script {
                    sh """
                    sudo apt update && sudo apt install -y \\
                        build-essential \\
                        libbz2-dev \\
                        libssl-dev \\
                        libreadline-dev \\
                        zlib1g-dev \\
                        libsqlite3-dev \\
                        libffi-dev \\
                        liblzma-dev \\
                        xz-utils
                    """
                }
            }
        }

        stage('Extract Source') {
            steps {
                script {
                    sh "cd ${SRC_DIR} && tar -xvf node-v${NODE_VERSION}.tar.gz"
                }
            }
        }

        stage('Configure & Compile') {
            steps {
                script {
                    sh """
                    cd ${SRC_DIR}/node-v${NODE_VERSION}
                    export PYTHON=${PYTHON_BIN}  # Set Python 3.12 explicitly
                    ./configure --prefix=${INSTALL_PATH} --enable-optimization
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
