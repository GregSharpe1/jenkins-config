job('Job Example 1'){
  description 'Heres a job created with JobDSL from Jenkins CASC'
}

organizationFolder('github') {
  description('This contains repositories within Github with Jenkinsfile')
  displayName('Github Organization Folder')

  organizations {
    github {
      repoOwner('GregSharpe1')
      apiUri("https://api.github.com")
      credentialsId('github-token')
    }
  }

  projectFactories {
    workflowMultiBranchProjectFactory {
      scriptPath('Jenkinsfile')
    }
  }

  orphanedItemStrategy {
    defaultOrphanedItemStrategy {
      pruneDeadBranches(true)
      daysToKeepStr('30')
      numToKeepStr('30')
    }
  }
}
