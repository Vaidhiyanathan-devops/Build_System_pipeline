pipeline {
    agent any  // Runs on any available agent

    environment {
        SRC_TAR = 'Python-3.12.9.tgz'
        BUILD_DIR = 'build'
        INSTALL_DIR = '/opt/zoho/python_3.12.9'
        FINAL_TAR = 'Python-3.12.9-compiled.tar.gz'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Vaidhiyanathan-devops/Jenkins_test.git', branch: 'main'
            }
        }

        stage('Extract Source') {
            steps {
                sh 'mkdir -p ${BUILD_DIR} && tar -xzf ${SRC_TAR} -C ${BUILD_DIR} --strip-components=1'
            }
        }

        stage('Configure') {
            steps {
                sh 'cd ${BUILD_DIR} && ./configure --prefix=${INSTALL_DIR}'
            }
        }

        stage('Compile') {
            steps {
                sh 'cd ${BUILD_DIR} && make -j$(nproc)'
            }
        }

        stage('Install') {
            steps {
                sh 'cd ${BUILD_DIR} && make install'
            }
        }

        stage('Package Compiled Version') {
            steps {
                sh 'tar -czf ${FINAL_TAR} -C ${INSTALL_DIR} .'
                archiveArtifacts artifacts: '${FINAL_TAR}', fingerprint: true
            }
        }
    }

    post {
        always {
            node('main') {  // Ensuring cleanup runs inside a node
                sh 'echo "Cleaning up workspace..."'
                sh 'rm -rf ${BUILD_DIR} ${INSTALL_DIR} ${FINAL_TAR}'
            }
        }
        success {
            echo "Pipeline completed successfully! ✅"
        }
        failure {
            echo "Pipeline failed! ❌ Check logs."
        }
    }
}
