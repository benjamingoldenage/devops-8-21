# Hands-on Jenkins-01 : Deploying Application to Staging/Production Environment with Jenkins

Purpose of the this hands-on training is to learn how to deploy applications to Staging/Production Environment with Jenkins.

## Learning Outcomes

At the end of the this hands-on training, students will be able to;

- deploy an application to Staging/Production Environment with Jenkins

- automate a Maven project as Pipeline.


## Outline

- Part 1 - Deploy Application to Staging Environment

- Part 2 - Update the application and deploy to the staging environment

- Part 3 - Build Pipeline Plugin

- Part 4 - Deploy application to production environment

- Part 5 - Automate Existing Maven Project as Pipeline with Jenkins



## Part 1 - Deploy Application to Staging Environment

- Go to `tomcat-application` view

- Select `New Item`

- Enter name as `Deploy-Application-Staging-Environment`

- Select `Free Style Project`

- For Description : `This Job will deploy a Java-Tomcat-Sample to the staging environment.`

- At `General Tab`, select `Strategy` and for `Days to keep builds` enter `5` and `Max # of builds to keep` enter `1`.

- At `Build Environments` section, select `Delete workspace before build starts` and `Add timestamps to the Console Output` options.

- For `Build`, select `Copy artifact from another project`

  - Select `Project name` as `Package-Application`
  - Select `Latest successful build` for `Which build`
  - Check `Stable build only`
  - For `Artifact to copy`, fill in `**/*.war`

- For `Add post-build action`, select `Deploy war/ear to a container`
  - for `WAR/EAR files`, fill in `**/*.war`.
  - for `Context path`, filll in `/`.
  - for `Containers`, select `Tomcat 8.x Remote`.
  - Add credentials
    - Add -> Jenkins
      - Add `username` and `password` as `tomcat/tomcat`.
    - From `Credentials`, select `tomcat/*****`.
  - for `Tomcat URL`, select `private ip` of staging tomcat server like `http://172.31.20.75:8080`.

- Click on `Save`.

- Go to the `Deploy-Application-Staging-Environment` 

- Click `Build Now`.

- Explain the built results.

- Open the staging server url with port # `8080` and check the results.

## Part 2 - Update the application and deploy to the staging environment

-  Go to the `Package-Application`
   -  Select `Configure`
   -  Select the `Post-build Actions` tab
   -  From `Add post-build action`, `Build othe projects`
      -  For `Projects to build`, fill in `Deploy-Application-Staging-Environment`
      -  And select `Trigger only if build is stable` option.
   - Go to the `Build Triggers` tab
     - Select `Poll SCM`
       - In `Schedule`, fill in `* * * * *` (5 stars)
         - You will see the warning `Do you really mean "every minute" when you say "* * * * *"? Perhaps you meant "H * * * *" to poll once per hour`
  
   - `Save` the modified job.

   - At `Project Package-Application`  page, you will see `Downstream Projects` : `Deploy-Application-Staging-Environment`


- Update the web site content, and commit to the GitHub.

- Go to the  `Project Package-Application` and `Deploy-Application-Staging-Environment` pages and observe the auto build & deploy process.

- Explain the built results.

- Open the staging server url with port # `8080` and check the results.

## Part 3 - Build Pipeline Plugin

- Go to the `Manage Jenkins`

- Select `Manage Plugins`

- Select `Available` tab

- Look for the `Build Pipeline` plugin

- If not installed, install `Build Pipeline` plugin with `Install without restart` option.

- Now, go to the dashboard and click `+` to add a new `View`
  - for `View name`, fill in `Pipeline-Tomcat-View`
  - Select the `Build Pipeline View`
  - Click `OK`
  
- for `Build Pipeline View Title`, enter `Deploy-Application-Staging-Environment` 
  
- for `Pipeline Flow: Layout`, select `Based on upstreram/downstream relationship`
  
- for `Select Initial Job`, select `Package-Application` job.
  
- Select `OK`.
  
- You will `Build Pipeline: Deploy-Application-Staging-Environment` with a pretty grahical presentation.
  
- Press the `Run`, and observe the behavior. Click the `Refresh` button of the browser.
  
- Explain the `console` and `re-run` buttons at the right bottom corner of the jobs.


## Part 4 - Deploy application to production environment

- Go to the dashboard

- Select `tomcat-application` view.

- Select `New Item`

- Enter name as `Deploy-Application-Production-Environment`

- Select `Free Style Project`

- For Description : `This Job will deploy a Java-Tomcat-Sample to the deployment environment.`

- At `General Tab`, select `Strategy` and for `Days to keep builds` enter `5` and `Max # of builds to keep` enter `1`.

- At `Build Environments` section, select `Delete workspace before build starts` and `Add timestamps to the Console Output` and `Color ANSI Console Outputoptions`.

- For `Build`, select `Copy artifact from another project`

  - Select `Project name` as `Package-Application`
  - Select `Latest successful build` for `Which build`
  - Check `Stable build only`
  - For `Artifact to copy`, fill in `**/*.war`

- For `Add post-build action`, select `Deploy war/ear to a container`
  - for `WAR/EAR files`, fill in `**/*.war`.
  - for `Context path`, filll in `/`.
  - for `Containers`, select `Tomcat 8.x Remote`.
  - From `Credentials`, select `tomcat/*****`.
  - for `Tomcat URL`, select `private ip` of production tomcat server like `http://172.31.28.5:8080`.

- Click on `Save`.

- Now add this job to the pipeline

- Go to the `Deploy-Application-Staging-Environment` page

- Select `Configure`

- Go to the `Post-build Actions`

- Select `Build other projects (manual step)` from `Add post-build action`

- for `Downstream Project Names`, select  `Deploy-Application-Production-Environment`

- `Save` and `Refresh` the page and observe

  - Upstream Projects : Package-Application
  - Downstream Projects :Deploy-Application-Production-Environment

- Got to the `Pipeline-Tomcat-View` and observe the pipeline (`Deploy-Application-Production-Environment` added to the pipeline).

## Part 5 - Automate Existing Maven Project as Pipeline with Jenkins

- Go to the Jenkins dashboard and click on `New Item` to create a pipeline.

- Enter `package-application-code-pipeline` then select `Pipeline` and click `OK`.

- Enter `This code pipeline Job is to package the maven project` in the description field.

- At `General Tab`, select `Discard old build`,
  -  select `Strategy` and 
     -  for `Days to keep builds` enter `5` and 
     -  `Max # of builds to keep` enter `1`.

- At `Advanced Project Options: Pipeline` section

  - for definition, select `Pipeline script from SCM`
  - for SCM, select `Git`
    - for `Repository URL`, select `https://github.com/JBCodeWorld/java-tomcat-sample.git`, show the `Jenkinsfile` here.
    - for `Branch Specifier`, enter `*/main` as the GitHub branch is like that.
    - approve that the `Script Path` is `Jenkinsfile`
- `Save` and `Build Now` and observe the behavior.

- Copy the existing 2 jobs ( `Deploy-Application-Staging-Environment` , `Deploy-Application-Production-Environment` ) and modify them for pipeline.

- Go to dashbord click on `New Item` to copy `Deploy-Application-Staging-Environment`

- For name, enter `deploy-application-staging-environment-pipeline`

- At the bottom, `Copy from`, enter `Deploy-Application-Staging-Environment`

- Click `OK`, and `Save`

- Go to dashbord click on `New Item` to copy `Deploy-Application-Production-Environment`

- For name, enter `deploy-application-production-environment-pipeline`

- At the bottom, `Copy from`, enter `Deploy-Application-Production-Environment`

- Click `OK`, and `Save`


- Go to the `deploy-application-staging-environment-pipeline` job

- Find the `Build` section,
  - for `Project name`, enter `package-application-code-pipeline` 
  - select `Last successful build`

- At `Post-build Actions (manual steps)`, click the `X` to remove this section.

- `Save` the job


- Go to the `deploy-application-production-environment-pipeline` job

- Find the `Build` section,
  - for `Project name`, enter `package-application-code-pipeline` 
  - select `Last successful build`

- `Save` the job

- Now, update the `Jenkinsfile` to include last 2 stages. For this purpose, add these 2 stages in `Jenkinsfile` like below:

```text
        stage('Deploy to Staging Environment'){
            steps{
                build job: 'deploy-application-staging-environment-pipeline'

            }
            
        }
        stage('Deploy to Production Environment'){
            steps{
                timeout(time:5, unit:'DAYS'){
                    input message:'Approve PRODUCTION Deployment?'
                }
                build job: 'deploy-application-production-environment-pipeline'
            }
        }
```

- Note: You can also use updated `Jenkinsfile2` file instead of updating `Jenkinsfile`.

- Go to the `package-application-code-pipeline` then select `Build Now` and observe the behaviors.


