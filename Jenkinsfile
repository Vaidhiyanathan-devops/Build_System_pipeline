pipeline {
    agent any
    environment {
        PYTHON_VERSION = "3.12.9"  // Updated Python version
        INSTALL_DIR = "/opt/zoho/Python_3.12"
        SOURCE_TAR = "/tmp/packages/Python-${PYTHON_VERSION}.tgz"
        BUILD_DIR = "Python-${PYTHON_VERSION}"
        ARCHIVE_NAME = "Python-${PYTHON_VERSION}-compiled.tar.gz"
    }
    stages {
        stage('Cleanup Workspace') {
            steps {
                sh '''
                rm -rf ${BUILD_DIR} ${INSTALL_DIR}
                '''
            }
        }
        stage('Extract Source Code') {
            steps {
                sh '''
                tar -xvzf ${SOURCE_TAR}
                '''
            }
        }
        stage('Install Dependencies') {
            steps {
                sh '''
                sudo apt update
                sudo apt install -y build-essential libssl-dev zlib1g-dev
                '''
            }
        }
        stage('Configure Build') {
            steps {
                sh '''
                cd ${BUILD_DIR}
                ./configure --prefix=${INSTALL_DIR} --enable-optimizations
                '''
            }
        }
        stage('Compile Source Code') {
            steps {
                sh '''
                cd ${BUILD_DIR}
                make -j$(nproc)
                '''
            }
        }
        stage('Package Compiled Files') {
            steps {
                sh '''
                mkdir -p ${INSTALL_DIR}
                make install DESTDIR=${INSTALL_DIR}
                cd /opt/zoho
                tar -czvf ${ARCHIVE_NAME} Python_3.12
                mv ${ARCHIVE_NAME} ${WORKSPACE}/
                '''
            }
        }
        stage('Archive Compiled Tar') {
            steps {
                archiveArtifacts artifacts: '${ARCHIVE_NAME}', fingerprint: true
            }
        }
    }
}
