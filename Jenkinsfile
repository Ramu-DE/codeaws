pipeline {
    agent any

    environment {
        DB_HOST = 'cicd.c5eoci8igx03.us-east-1.rds.amazonaws.com'        // AWS RDS Endpoint
        DB_PORT = '5432'                     // PostgreSQL default port
        DB_NAME = 'cicd'       // Database name
        AWS_REGION = 'us-east-1f'       // AWS region of your RDS instance
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Clone the repository containing PostgreSQL scripts
                git 'https://github.com/Ramu-DE/codeaws.git'
            }
        }

        stage('Validate SQL Scripts') {
            steps {
                // Optionally, validate your SQL scripts for syntax errors
                // Ensure 'psql' is installed on the Jenkins agent
                script {
                    def sqlFiles = findFiles(glob: 'migrations/*.sql')
                    for (sqlFile in sqlFiles) {
                        sh "psql -h $DB_HOST -U $DB_USER -d $DB_NAME -p $DB_PORT -f ${sqlFile} --dry-run"
                    }
                }
            }
        }

        stage('Run Database Migrations') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'postgres-rds-credentials', usernameVariable: 'DB_USER', passwordVariable: 'DB_PASS')]) {
                    script {
                        def sqlFiles = findFiles(glob: 'migrations/*.sql')
                        for (sqlFile in sqlFiles) {
                            sh "psql -h $DB_HOST -U $DB_USER -d $DB_NAME -p $DB_PORT -f ${sqlFile}"
                        }
                    }
                }
            }
        }

        stage('Notify Deployment') {
            steps {
                // Notify stakeholders of a successful deployment
                mail to: 'drop2ramu@gmail.com',
                     subject: "PostgreSQL Deployment Successful",
                     body: "The PostgreSQL scripts have been successfully deployed to the AWS RDS instance."
            }
        }
    }

    post {
        failure {
            // Notify stakeholders if the deployment fails
            mail to: 'drop2ramu@gmail.com',
                 subject: "PostgreSQL Deployment Failed",
                 body: "The PostgreSQL deployment has failed. Please check the Jenkins logs for details."
        }
    }
}
