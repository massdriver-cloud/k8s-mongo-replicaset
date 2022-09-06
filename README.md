[![Massdriver][logo]][website]

# k8s-mongo-replicaset

[![Release][release_shield]][release_url]
[![Contributors][contributors_shield]][contributors_url]
[![Forks][forks_shield]][forks_url]
[![Stargazers][stars_shield]][stars_url]
[![Issues][issues_shield]][issues_url]
[![MIT License][license_shield]][license_url]


Deploy MongoDB to your Kubernetes cluster.


---

## Design

For detailed information, check out our [Operator Guide](operator.mdx) for this bundle.

## Usage

Our bundles aren't intended to be used locally, outside of testing. Instead, our bundles are designed to be configured, connected, deployed and monitored in the [Massdriver][website] platform.

### What are Bundles?

Bundles are the basic building blocks of infrastructure, applications, and architectures in [Massdriver][website]. Read more [here](https://docs.massdriver.cloud/concepts/bundles).

## Bundle


<!-- COMPLIANCE:START -->

Security and compliance scanning of our bundles is performed using [Bridgecrew](https://www.bridgecrew.cloud/). Massdriver also offers security and compliance scanning of operational infrastructure configured and deployed using the platform.

| Benchmark | Description |
|--------|---------------|
| [![Infrastructure Security](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/k8s-mongo-replicaset/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fk8s-mongo-replicaset&benchmark=INFRASTRUCTURE+SECURITY) | Infrastructure Security Compliance |
| [![PCI-DSS](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/k8s-mongo-replicaset/pci)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fk8s-mongo-replicaset&benchmark=PCI-DSS+V3.2) | Payment Card Industry Data Security Standards Compliance |
| [![NIST-800-53](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/k8s-mongo-replicaset/nist)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fk8s-mongo-replicaset&benchmark=NIST-800-53) | National Institute of Standards and Technology Compliance |
| [![ISO27001](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/k8s-mongo-replicaset/iso)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fk8s-mongo-replicaset&benchmark=ISO27001) | Information Security Management System, ISO/IEC 27001 Compliance |
| [![SOC2](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/k8s-mongo-replicaset/soc2)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fk8s-mongo-replicaset&benchmark=SOC2)| Service Organization Control 2 Compliance |
| [![HIPAA](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/k8s-mongo-replicaset/hipaa)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fk8s-mongo-replicaset&benchmark=HIPAA) | Health Insurance Portability and Accountability Compliance |

<!-- COMPLIANCE:END -->

### Params

Form input parameters for configuring a bundle for deployment.

<details>
<summary>View</summary>

<!-- PARAMS:START -->
## Properties

- **`database_name`** *(string)*: Name of the mongo database to create.
- **`instance_configuration`** *(object)*
  - **`cpu_limit`** *(number)*: Unit is in CPUs. Decimal numbers are allowed (3 digits of precision). Value must be between 0.001 and 32. Minimum: `0.5`. Maximum: `32`.
  - **`disk_size_gb`** *(integer)*: The size (in Gb) of the PVC to request. Must be an integer between 10 and 1000. Minimum: `10`. Maximum: `1000`.
  - **`memory_limit_gib`** *(number)*: Unit is Gi. Decimal numbers are allowed. Value must be between 0.5 and 64. Minimum: `0.5`. Maximum: `64`.
- **`namespace`** *(string)*: The namespace to deploy the replicaset in. Default: `default`.
- **`replica_configuration`** *(object)*: Replica configuration.
  - **`number_of_replicas`** *(integer)*: Number of read replicas to create. Must be an integer between 0 and 5. Minimum: `0`. Maximum: `5`.
## Examples

  ```json
  {
      "__name": "Development",
      "instance_configuration": {
          "cpu_limit": 0.8,
          "disk_size_gb": 10,
          "memory_limit_gib": 2
      },
      "replica_configuration": {
          "number_of_replicas": 0
      }
  }
  ```

  ```json
  {
      "__name": "Production",
      "instance_configuration": {
          "cpu_limit": 4.2,
          "disk_size_gb": 50,
          "memory_limit_gib": 8
      },
      "replica_configuration": {
          "number_of_replicas": 2
      }
  }
  ```

<!-- PARAMS:END -->

</details>

### Connections

Connections from other bundles that this bundle depends on.

<details>
<summary>View</summary>

<!-- CONNECTIONS:START -->
## Properties

- **`kubernetes_cluster`** *(object)*: Kubernetes cluster authentication and cloud-specific configuration. Cannot contain additional properties.
  - **`data`** *(object)*
    - **`authentication`** *(object)*
      - **`cluster`** *(object)*
        - **`certificate-authority-data`** *(string)*
        - **`server`** *(string)*
      - **`user`** *(object)*
        - **`token`** *(string)*
    - **`infrastructure`** *(object)*: Cloud specific Kubernetes configuration data.
      - **One of**
        - AWS EKS infrastructure config*object*: . Cannot contain additional properties.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

          - **`oidc_issuer_url`** *(string)*: An HTTPS endpoint URL.

            Examples:
            ```json
            "https://example.com/some/path"
            ```

            ```json
            "https://massdriver.cloud"
            ```

        - Azure Infrastructure Resource ID*object*: Minimal Azure Infrastructure Config. Cannot contain additional properties.
          - **`ari`** *(string)*: Azure Resource ID.

            Examples:
            ```json
            "/subscriptions/12345678-1234-1234-abcd-1234567890ab/resourceGroups/resource-group-name/providers/Microsoft.Network/virtualNetworks/network-name"
            ```

        - GCP Infrastructure GRN*object*: Minimal GCP Infrastructure Config. Cannot contain additional properties.
          - **`grn`** *(string)*: GCP Resource Name (GRN).

            Examples:
            ```json
            "projects/my-project/global/networks/my-global-network"
            ```

            ```json
            "projects/my-project/regions/us-west2/subnetworks/my-subnetwork"
            ```

            ```json
            "projects/my-project/topics/my-pubsub-topic"
            ```

            ```json
            "projects/my-project/subscriptions/my-pubsub-subscription"
            ```

            ```json
            "projects/my-project/locations/us-west2/instances/my-redis-instance"
            ```

            ```json
            "projects/my-project/locations/us-west2/clusters/my-gke-cluster"
            ```

  - **`specs`** *(object)*
    - **`kubernetes`** *(object)*: Kubernetes distribution and version specifications.
      - **`cloud`** *(string)*: Must be one of: `['aws', 'gcp', 'azure']`.
      - **`distribution`** *(string)*: Must be one of: `['eks', 'gke', 'aks']`.
      - **`platform_version`** *(string)*
      - **`version`** *(string)*
<!-- CONNECTIONS:END -->

</details>

### Artifacts

Resources created by this bundle that can be connected to other bundles.

<details>
<summary>View</summary>

<!-- ARTIFACTS:START -->
## Properties

- **`mongo_authentication`** *(object)*: mongo cluster authentication and cloud-specific configuration. Cannot contain additional properties.
  - **`data`** *(object)*
    - **`authentication`**: Mongo connection string. Cannot contain additional properties.
      - **`hostname`** *(string)*
      - **`password`** *(string)*
      - **`port`** *(integer)*: Port number. Minimum: `0`. Maximum: `65535`.
      - **`username`** *(string)*
    - **`infrastructure`** *(object)*: Mongo cluster infrastructure configuration.
      - **One of**
        - Kuberenetes infrastructure config*object*: . Cannot contain additional properties.
          - **`kubernetes_namespace`** *(string)*
          - **`kubernetes_service`** *(string)*
        - Azure Infrastructure Resource ID*object*: Minimal Azure Infrastructure Config. Cannot contain additional properties.
          - **`ari`** *(string)*: Azure Resource ID.

            Examples:
            ```json
            "/subscriptions/12345678-1234-1234-abcd-1234567890ab/resourceGroups/resource-group-name/providers/Microsoft.Network/virtualNetworks/network-name"
            ```

  - **`specs`** *(object)*
    - **`mongo`** *(object)*: Informs downstream bundles of Mongo specific data. Cannot contain additional properties.
      - **`version`** *(string)*: Currently deployed Mongo version.
<!-- ARTIFACTS:END -->

</details>

## Contributing

<!-- CONTRIBUTING:START -->

### Bug Reports & Feature Requests

Did we miss something? Please [submit an issue](https://github.com/massdriver-cloud/k8s-mongo-replicaset/issues) to report any bugs or request additional features.

### Developing

**Note**: Massdriver bundles are intended to be tightly use-case scoped, intention-based, reusable pieces of IaC for use in the [Massdriver][website] platform. For this reason, major feature additions that broaden the scope of an existing bundle are likely to be rejected by the community.

Still want to get involved? First check out our [contribution guidelines](https://docs.massdriver.cloud/bundles/contributing).

### Fix or Fork

If your use-case isn't covered by this bundle, you can still get involved! Massdriver is designed to be an extensible platform. Fork this bundle, or [create your own bundle from scratch](https://docs.massdriver.cloud/bundles/development)!

<!-- CONTRIBUTING:END -->

## Connect

<!-- CONNECT:START -->

Questions? Concerns? Adulations? We'd love to hear from you!

Please connect with us!

[![Email][email_shield]][email_url]
[![GitHub][github_shield]][github_url]
[![LinkedIn][linkedin_shield]][linkedin_url]
[![Twitter][twitter_shield]][twitter_url]
[![YouTube][youtube_shield]][youtube_url]
[![Reddit][reddit_shield]][reddit_url]

<!-- markdownlint-disable -->

[logo]: https://raw.githubusercontent.com/massdriver-cloud/docs/main/static/img/logo-with-logotype-horizontal-400x110.svg
[docs]: https://docs.massdriver.cloud/?utm_source=github&utm_medium=readme&utm_campaign=k8s-mongo-replicaset&utm_content=docs
[website]: https://www.massdriver.cloud/?utm_source=github&utm_medium=readme&utm_campaign=k8s-mongo-replicaset&utm_content=website
[github]: https://github.com/massdriver-cloud?utm_source=github&utm_medium=readme&utm_campaign=k8s-mongo-replicaset&utm_content=github
[slack]: https://massdriverworkspace.slack.com/?utm_source=github&utm_medium=readme&utm_campaign=k8s-mongo-replicaset&utm_content=slack
[linkedin]: https://www.linkedin.com/company/massdriver/?utm_source=github&utm_medium=readme&utm_campaign=k8s-mongo-replicaset&utm_content=linkedin



[contributors_shield]: https://img.shields.io/github/contributors/massdriver-cloud/k8s-mongo-replicaset.svg?style=for-the-badge
[contributors_url]: https://github.com/massdriver-cloud/k8s-mongo-replicaset/graphs/contributors
[forks_shield]: https://img.shields.io/github/forks/massdriver-cloud/k8s-mongo-replicaset.svg?style=for-the-badge
[forks_url]: https://github.com/massdriver-cloud/k8s-mongo-replicaset/network/members
[stars_shield]: https://img.shields.io/github/stars/massdriver-cloud/k8s-mongo-replicaset.svg?style=for-the-badge
[stars_url]: https://github.com/massdriver-cloud/k8s-mongo-replicaset/stargazers
[issues_shield]: https://img.shields.io/github/issues/massdriver-cloud/k8s-mongo-replicaset.svg?style=for-the-badge
[issues_url]: https://github.com/massdriver-cloud/k8s-mongo-replicaset/issues
[release_url]: https://github.com/massdriver-cloud/k8s-mongo-replicaset/releases/latest
[release_shield]: https://img.shields.io/github/release/massdriver-cloud/k8s-mongo-replicaset.svg?style=for-the-badge
[license_shield]: https://img.shields.io/github/license/massdriver-cloud/k8s-mongo-replicaset.svg?style=for-the-badge
[license_url]: https://github.com/massdriver-cloud/k8s-mongo-replicaset/blob/main/LICENSE


[email_url]: mailto:support@massdriver.cloud
[email_shield]: https://img.shields.io/badge/email-Massdriver-black.svg?style=for-the-badge&logo=mail.ru&color=000000
[github_url]: mailto:support@massdriver.cloud
[github_shield]: https://img.shields.io/badge/follow-Github-black.svg?style=for-the-badge&logo=github&color=181717
[linkedin_url]: https://linkedin.com/in/massdriver-cloud
[linkedin_shield]: https://img.shields.io/badge/follow-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&color=0A66C2
[twitter_url]: https://twitter.com/massdriver?utm_source=github&utm_medium=readme&utm_campaign=k8s-mongo-replicaset&utm_content=twitter
[twitter_shield]: https://img.shields.io/badge/follow-Twitter-black.svg?style=for-the-badge&logo=twitter&color=1DA1F2
[discourse_url]: https://community.massdriver.cloud?utm_source=github&utm_medium=readme&utm_campaign=k8s-mongo-replicaset&utm_content=discourse
[discourse_shield]: https://img.shields.io/badge/join-Discourse-black.svg?style=for-the-badge&logo=discourse&color=000000
[youtube_url]: https://www.youtube.com/channel/UCfj8P7MJcdlem2DJpvymtaQ
[youtube_shield]: https://img.shields.io/badge/subscribe-Youtube-black.svg?style=for-the-badge&logo=youtube&color=FF0000
[reddit_url]: https://www.reddit.com/r/massdriver
[reddit_shield]: https://img.shields.io/badge/subscribe-Reddit-black.svg?style=for-the-badge&logo=reddit&color=FF4500

<!-- markdownlint-restore -->

<!-- CONNECT:END -->
