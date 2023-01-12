# Appdome CircleCI Orb


[![CircleCI Build Status](https://circleci.com/gh/Appdome/appdome-orb.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/Appdome/appdome-orb) [![CircleCI Orb Version](https://badges.circleci.com/orbs/appdome/appdome-orb.svg)](https://circleci.com/orbs/registry/orb/appdome/appdome-orb) [![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/Appdome/appdome-orb/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)



Easily secure and customize your mobile apps on CircleCI using the Appdome Orb. No coding or technical expertise is required. Automate the process of adding security features such as encryption, biometric authentication, and more to your mobile apps. Additionally, sign your app with your own enterprise certificate for added flexibility and control. Get the flexibility and control you need to secure and customize your mobile apps with the Appdome Orb.


### Usage

For full usage guidelines, see the [orb registry listing](https://circleci.com/developer/orbs/orb/appdome/appdome-orb).

## Resources

[CircleCI Orb Registry Page](https://circleci.com/orbs/registry/orb/appdome/appdome-orb) - The official registry page of this orb for all versions, executors, commands, and jobs described.

[CircleCI Orb Docs](https://circleci.com/docs/2.0/orb-intro/#section=configuration) - Docs for using, creating, and publishing CircleCI Orbs.

### Contribute

We welcome [issues](https://github.com/Appdome/appdome-orb/issues) to and [pull requests](https://github.com/Appdome/appdome-orb/pulls) against this repository!

### How to Publish An Update
1. Merge pull requests with desired changes to the main branch.
    - For the best experience, squash-and-merge and use [Conventional Commit Messages](https://conventionalcommits.org/).
2. Find the current version of the orb.
    - You can run `circleci orb info appdome/appdome-orb | grep "Latest"` to see the current version.
3. Create a [new Release](https://github.com/Appdome/appdome-orb/releases/new) on GitHub.
    - Click "Choose a tag" and _create_ a new [semantically versioned](http://semver.org/) tag. (ex: v1.0.0)
      - We will have an opportunity to change this before we publish if needed after the next step.
4.  Click _"+ Auto-generate release notes"_.
    - This will create a summary of all of the merged pull requests since the previous release.
    - If you have used _[Conventional Commit Messages](https://conventionalcommits.org/)_ it will be easy to determine what types of changes were made, allowing you to ensure the correct version tag is being published.
5. Now ensure the version tag selected is semantically accurate based on the changes included.
6. Click _"Publish Release"_.
    - This will push a new tag and trigger your publishing pipeline on CircleCI.
