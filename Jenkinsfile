pipeline {
    agent any

    environment {
        SOURCE_TAR = "/tmp/packages/Python-3.12.9.tgz"
        EXTRACT_DIR = "Python-3.12.9"
        INSTALL_PATH = "/opt/zoho/Python_3.12"
        OUTPUT_TAR = "Python-3.12.9-compiled.tgz"
    }

    stages {
        stage('Prepare Environment') {
            steps {
                sh '''
                echo "🔹 Cleaning previous build if exists..."
                rm -rf ${EXTRACT_DIR} ${INSTALL_PATH} ${OUTPUT_TAR}

                echo "🔹 Creating install directory..."
                mkdir -p ${INSTALL_PATH}
                '''
            }
        }

        stage('Extract Source Code') {
            steps {
                sh '''
                echo "🔹 Extracting Python Source..."
                tar -xvzf ${SOURCE_TAR}
                cd ${EXTRACT_DIR}
                '''
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                echo "🔹 Installing build dependencies..."
                sudo apt update && sudo apt install -y build-essential libssl-dev zlib1g-dev
                '''
            }
        }

        stage('Configure') {
            steps {
                sh '''
                echo "🔹 Running ./configure..."
                cd ${EXTRACT_DIR}
                ./configure --prefix=${INSTALL_PATH} --enable-optimizations
                '''
            }
        }

        stage('Compile Source') {
            steps {
                sh '''
                echo "🔹 Compiling Python..."
                cd ${EXTRACT_DIR}
                make -j$(nproc)
                '''
            }
        }

        stage('Package Compiled Files') {
            steps {
                sh '''
                echo "🔹 Creating tar of compiled files..."
                tar -czvf ${OUTPUT_TAR} -C ${INSTALL_PATH} .
                '''
            }
        }

        stage('Upload to GitHub') {
            steps {
                sh '''
                echo "🔹 Uploading compiled tar to GitHub repo..."
                # Replace this with your actual GitHub repo commands
                # git clone https://your-repo-url.git
                # cp ${OUTPUT_TAR} your-repo/
                # cd your-repo
                # git add ${OUTPUT_TAR}
                # git commit -m "Added compiled Python 3.12.9"
                # git push origin main
                '''
            }
        }
    }

    post {
        always {
            sh '''
            echo "🔹 Cleaning up workspace..."
            rm -rf ${EXTRACT_DIR} ${OUTPUT_TAR}
            '''
        }
    }
}
