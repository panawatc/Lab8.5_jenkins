pipeline {
    agent any

    environment {
        // กำหนดชื่อโฟลเดอร์เก็บผลลัพธ์
        RESULTS_DIR = "results"
    }

    stages {
        stage('Cleanup') {
            steps {
                echo "Cleaning up old results..."
                // ลบโฟลเดอร์ผลลัพธ์เก่า (ถ้ามี) เพื่อไม่ให้ผลเทสเก่าปนกับใหม่
                sh "rm -rf ${RESULTS_DIR}"
            }
        }

        stage('Build Check') {
            steps {
                echo "Verifying Environment..."
                // เช็คเวอร์ชันโปรแกรมต่างๆ เพื่อความชัวร์
                sh 'python3 --version'
                sh 'robot --version'
                sh 'chromium --version'
            }
        }

        stage('Run Robot Tests') {
            steps {
                // สั่งรัน Robot โดยบอกให้ไปหาไฟล์ในโฟลเดอร์ tests/
                // และเก็บผลลัพธ์ลงในโฟลเดอร์ results (ตามตัวแปร RESULTS_DIR)
                sh "robot -d ${RESULTS_DIR} tests/"
            }
        }
    }

    post {
        always {
            // ส่วนนี้จะทำงานเสมอ ไม่ว่าจะ Pass หรือ Fail
            // ใช้ Robot Framework Plugin อ่านผลจากโฟลเดอร์ results
            step([$class: 'RobotPublisher',
                outputPath: "${RESULTS_DIR}",
                outputFileName: 'output.xml',
                reportFileName: 'report.html',
                logFileName: 'log.html',
                disableReports: false,
                passThreshold: 80.0,
                unstableThreshold: 20.0
            ])
            
            // เก็บไฟล์ผลลัพธ์ไว้ให้กดดาวน์โหลดได้จากหน้า Jenkins
            archiveArtifacts artifacts: "${RESULTS_DIR}/*.*", allowEmptyArchive: true
        }
    }
}