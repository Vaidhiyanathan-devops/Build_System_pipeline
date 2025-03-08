pipeline {
    agent any

    environment {
        SRC_DIR = "/tmp/packages"
        NODE_VERSION = "22.13.1"
        INSTALL_PATH = "/opt/zoho/nodejs22.13"
        TAR_OUTPUT = "/tmp/nodejs-${NODE_VERSION}.tar.gz"
        GITHUB_REPO = "https://github.com/Vaidhiyanathan-devops/Jenkins_test.git"
        GIT_BRANCH = "main"
        NODE_SOURCE_TARBALL = "node-v${NODE_VERSION}.tar.gz"
        NODE_SOURCE_DIR = "node-v${NODE_VERSION}"
    }

    stages {
        stage('Download Source Code') {
            steps {
                script {
                    sh """
                    mkdir -p ${SRC_DIR}
                    cd ${SRC_DIR}
                    
                    # Download the correct source tarball if not present
                    if [ ! -f ${NODE_SOURCE_TARBALL} ]; then
                        wget https://nodejs.org/dist/v${NODE_VERSION}/${NODE_SOURCE_TARBALL}
                    fi
                    """
                }
            }
        }

        stage('Extract Source') {
            steps {
                script {
                    sh """
                    cd ${SRC_DIR}
                    
                    # Remove previous extraction if exists
                    rm -rf ${NODE_SOURCE_DIR}
                    
                    # Extract the source tarball
                    tar -xvf ${NODE_SOURCE_TARBALL}
                    """
                }
            }
        }

        stage('Configure & Compile') {
            steps {
                script {
                    sh """
                    cd ${SRC_DIR}/${NODE_SOURCE_DIR}
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
                    cp -r ${SRC_DIR}/${NODE_SOURCE_DIR}/out/* /tmp/nodejs-pack
                    tar -czvf ${TAR_OUTPUT} -C /tmp/nodejs-pack .
                    """
                }
            }
        }
    }
}
