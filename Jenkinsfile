pipeline {
    agent any

    environment {
        SRC_DIR = "/opt/packages"   // Changed from /tmp/packages to /opt/packages
        PYTHON_VERSION = "3.12.9"
        INSTALL_PATH = "/opt/zoho/Python_3.12"
        TAR_OUTPUT = "/opt/packages/python-${PYTHON_VERSION}.tar.gz"  // Changed output path
    }

    stages {
        stage('Cleanup Previous Build') {
            steps {
                script {
                    sh """
                    echo "Cleaning previous build..."
                    sudo rm -rf ${INSTALL_PATH} ${TAR_OUTPUT} /opt/python-pack
                    sudo rm -rf ${SRC_DIR}/Python-${PYTHON_VERSION}
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
                    cd ${SRC_DIR}
                    sudo tar -xvf ${SRC_DIR}/Python-${PYTHON_VERSION}.tgz
                    """
                }
            }
        }

        stage('Configure & Compile') {
            steps {
                script {
                    sh """
                    cd ${SRC_DIR}/Python-${PYTHON_VERSION}
                    sudo ./configure --prefix=${INSTALL_PATH} --enable-optimizations
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
                    make install
                    """
                }
            }
        }

        stage('Post-Check Python Installation') {
            steps {
                script {
                    sh """
                    echo "Checking installed Python version..."
                    ${INSTALL_PATH}/bin/python3 --version

                    echo "Testing Python imports..."
                    ${INSTALL_PATH}/bin/python3 -c "import ssl; import sqlite3; import bz2; print('All imports passed')"

                    echo "Running C program to test Python binary..."
                    cat > ${SRC_DIR}/test_python.c <<EOF
                    #include <Python.h>
                    #include <stdio.h>
                    int main() {
                        Py_Initialize();
                        if (Py_IsInitialized()) {
                            printf("Python C Embedding Test: Success\\n");
                        } else {
                            printf("Python C Embedding Test: Failed\\n");
                            return 1;
                        }
                        Py_Finalize();
                        return 0;
                    }
                    EOF
                    gcc -o ${SRC_DIR}/test_python ${SRC_DIR}/test_python.c -I${INSTALL_PATH}/include/python3.12 -L${INSTALL_PATH}/lib -lpython3.12
                    ${SRC_DIR}/test_python
                    """
                }
            }
        }

        stage('Package Compiled Binaries') {
            steps {
                script {
                    sh """
                    mkdir -p /opt/python-pack
                    cp -r ${INSTALL_PATH}/* /opt/python-pack
                    tar -czvf ${TAR_OUTPUT} -C /opt/python-pack .
                    """
                }
            }
        }
    }
}
