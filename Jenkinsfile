pipeline {
    agent any
    stages{
        stage('Verifying tools'){
            steps{
                sh '''
                echo "Verifying Terraform version"
                terraform version 
                
                echo "Verifying AWS version"
                aws --version
                '''
            }
        }
        stage('Git checkout'){
            steps{
                git branch: 'main', url: 'https://github.com/sujeeth29/terraform_project.git'
            }
        }
        stage('AWS Authentications'){
            steps{
                withCredentials([
                    [$class:'AmazonWebServicesCredentialsBinding',
                    credentialsId:'terraform_creds_aws']
                ]) {
                    sh ''' 
                        set -e
                        set +x
                        echo "Current AWS Identity"
                        aws sts get-caller-identity
                        
                        echo "Assuming IAM Role for Permissions"
                        
                        CREDS=$(aws sts assume-role \
                            --role-arn arn:aws:iam::744159940165:role/terraform_assume_role \
                            --role-session-name jenkins_terraform)
                        
                        export AWS_ACCESS_KEY_ID=$(echo "$CREDS" | jq -r '.Credentials.AccessKeyId')
                        export AWS_SECRET_ACCESS_KEY=$(echo "$CREDS" | jq -r '.Credentials.SecretAccessKey')
                        export AWS_SESSION_TOKEN=$(echo "$CREDS" | jq -r '.Credentials.SessionToken')
                        
                        unset CREDS
                        
                        set +x
                        echo "Assumed IAM Role"
                        aws sts get-caller-identity
                        
                        terraform init
                        
                        echo "Verifying Workspace"
                        terraform workspace select ${ENV} || \
                        terraform workspace new ${ENV}
                        echo "Current terraform workspace"
                        terraform workspace show
                        
                        echo "Running Plan"
                        terraform plan -var-file=envs/${ENV}.tfvars -out=tfplan
                        
                    '''
                }
            }
        }
        stage('Approval for Prod'){
            when {
                expression {
                    params.ENV == 'prod'
                }
            }
            steps{
                input (
                    message: 'Approve for Prod deployment ?',
                    ok: 'Approve & Deploy',
                    submitter: 'Prod Approver'
                )
            }
        }
        stage('QA Approver'){
            when{
                expression {
                    params.ENV == 'qa'
                }
            }
            steps{
                input(
                    message: 'Approve for QA deploymet ?',
                    ok: 'Approve & Deploy',
                    submitter: 'QA approver'
                )
            }
        }
        stage('Applying the Infra changes'){
            steps{
                withCredentials([
                    [$class:'AmazonWebServicesCredentialsBinding',
                    credentialsId:'terraform_creds_aws']
                ]){
                            sh ''' 
                                set -e
                                set +x
                                
                                CREDS=$(aws sts assume-role \
                                --role-arn arn:aws:iam::744159940165:role/terraform_assume_role \
                                --role-session-name jenkins_terraform)
                                
                                export AWS_ACCESS_KEY_ID=$(echo "$CREDS" | jq -r '.Credentials.AccessKeyId')
                                export AWS_SECRET_ACCESS_KEY=$(echo "$CREDS" | jq -r '.Credentials.SecretAccessKey')
                                export AWS_SESSION_TOKEN=$(echo "$CREDS" | jq -r '.Credentials.SessionToken')
                                
                                unset CREDS
                                echo "Applying Infra"
                                terraform workspace show
                        '''
                }
            }
        }
    }
}
