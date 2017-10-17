# Docker for IBM Cloud

_Overview of Docker for IBM Cloud_
![Docker for IBM Cloud Overview](https://raw.githubusercontent.com/JohnMTestOrg/Docker-EE/master/img/d4ic-ov.png)

With Docker for IBM Cloud's integration with [IBM Cloud Schematics](https://console.bluemix.net/docs/services/schematics/index.html#gettingstarted) templates, you can:
* Quickly [create an environment](#creating_your_swarm_environment) that simplifies infrastructure reuse
* Easily [validate and deploy resources](#deploying_resources_to_your_swarm_environment) to your Docker swarm

## Creating your swarm environment
With IBM Cloud Schematics, you can create your Docker for IBM Cloud swarm environment by entering the appropriate variables.

Before you begin:
* Make sure you have an [IBM Bluemix](https://console.bluemix.net/registration/) account that can create IBM Bluemix Infrastructure (SoftLayer) resources
* [Add your SSH key to IBM Bluemix Infrastructure (SoftLayer)](https://knowledgelayer.softlayer.com/procedure/add-ssh-key), label it, and copy the label to use in completing the environment variables
* Get your IBM Bluemix Infrastructure (SoftLayer) [account API credentials](https://knowledgelayer.softlayer.com/procedure/retrieve-your-api-key)
* If you have not already, [create a space](https://console.bluemix.net/docs/admin/orgs_spaces.html#spaceinfo) in the Bluemix US South region

Create your environment:
1. Select the Docker for IBM Cloud template.
2. Give your Schematics swarm environment a name in the **Environment Name** field.
3. Fill out the **Variables** form. The table describes the required variables:

    **Important**: You must supply all variables. Default values are provided, except for your IBM Bluemix Infrastructure (SoftLayer) API user name, API key, and SSH label.

    | Name | Description | Default Value |
    | ---- | ----------- | ------------- |
    | softlayer_username | To get your IBM Bluemix Infrastructure (Softlayer) user name, log in to SoftLayer, select your profile, and locate your API Username under the API Access Information section. | |
    | softlayer_api_key | To get your IBM Bluemix Infrastructure (SoftLayer) API key, log in to SoftLayer, select your profile, and locate your Authentication Key under the API Access Information section. | |
    | ssh_key_label | Your IBM Bluemix Infrastructure (SoftLayer) SSH key label for the manager node. To create a key, log in to SoftLayer and select Devices > Manager > SSH Keys > Add. | |
    | manager_count | Deploy 1, 3, or 5 manager nodes. | 3 |
    | worker_count | Deploy a minimum of 1 and maximum of 10 worker nodes. | 3 |
    | datacenter | The location (data center) you deploy the swarm to, such as dal10 or dal12. | dal10 |
    | name | The name for your swarm and prefix for the names of each node. | d4ic |

4. Click **Create**.

## Deploying resources to your swarm environment
After [creating your environment](#creating_your_swarm_environment), you must apply the variables to provision your swarm resources.

1. Click **Plan**.
2. Review the **Recent Activity** section to inspect the plan output for errors and resource changes.
3. Click **Apply** to launch your resources.

Great job! Your swarm resources are now provisioned, your environment's **Status** shows as **Active**, and you can review your resources under **Environment Resources**.

**Next Steps**: Explore what you can do with your Docker for IBM Cloud swarm, such as binding IBM Cloud services like Watson.<!--Need to add link to docs once those are available-->
