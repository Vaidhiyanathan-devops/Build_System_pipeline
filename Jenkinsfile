pipeline {
    agent any

    environment {
        SRC_DIR = "/tmp/packages"
        NODE_VERSION = "22.13.1"
        NODE_TAR = "node-v${NODE_VERSION}-linux-x64.tar.gz"
        INSTALL_PATH = "/opt/zoho/nodejs22.13"
        TAR_OUTPUT = "/tmp/nodejs-${NODE_VERSION}.tar.gz"
        GITHUB_REPO = "https://github.com/Vaidhiyanathan-devops/Jenkins_test.git"
        GIT_BRANCH = "main"
    }

    stages {
        stage('Extract Source') {
            steps {
                script {
                    sh """
                    cd ${SRC_DIR} 
                    tar -xvf ${NODE_TAR}
                    """
                }
            }
        }

        stage('Configure & Compile') {
            steps {
                script {
                    sh """
                    cd ${SRC_DIR}/node-v${NODE_VERSION}-linux-x64
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
                    cp -r ${SRC_DIR}/node-v${NODE_VERSION}-linux-x64/out/* /tmp/nodejs-pack
                    tar -czvf ${TAR_OUTPUT} -C /tmp/nodejs-pack .
                    """
                }
            }
        }

        
    }
}
