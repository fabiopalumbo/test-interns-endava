# test-interns-endava
Devops test for Endava Interns
## Instructions

<details>
<summary><b>Test Details</b></summary>

---
```

1- Build an infra in Terraform with the following requirements so that it can be executed by a client

Everything with HA and secured (principle of least possible permission).

Only 1 Network(VPC) of 4096 ips.

Only 4 Subnets of 256 ips (two public, two private with Internet access)

A bucket with a file called text.txt and contains the string "Hello World."

Entry point, an APIGW that sends traffic to Lambda.

Application, a Lambda that returns the content of the file texto.txt. The code can be in any language.

TF code must be delivered to a Git repository

The Git repository should contain a README that explains step by step how to run the terraform code and how to test the API remotely.

2 - Explain: how would the lambda code deploy flow be for someone who is not a devop and does not have access to Terraform, how would you automate it?

3 - Explain:

  a-What resources would you monitor?

  b-What values ​​of the resources would you monitor?

  c-What values ​​would you put an alert on?

4 - Explain: With what tool and how would you implement the monitoring/alerts.
```

</details>
