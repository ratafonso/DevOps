# Kubernetes Assessment

This module aims to assess the candidate in Kubernetes knowledge by asking a number of questions. It is recommended to use Docker Desktop with Kubernetes enabled as it will aid you in showing your working

## Scenario

You have been asked to quickly demonstate a few key areas of Kubernetes to a colleague as they are eager to learn and see some of the fundamentals in action.  

## Question 1

Create a deployment file called app using the image sirfragalot/docker-demo:dcus. The deployment must have two replicas.
Please name the file DeploymentTest.yaml.

## Question 2

Create the deployment in a namespace called test

## Question 3

Expose the Deployment so that app's contents can be seen on your local machine. Hint - sirfragalot/docker-demo:dcus runs on port 8080

## Question 4

Scale the replicas up to 5 and record the action. Show the recorded action and the new replicas being used

## Question 5

Using kubectl, show only the pods IPs and health under the headers IP and HEALTH

--------------------------------------------------------------------------------------------------------------------

# Initial Steps

In this step, we use Kubernetes Platform for execute containers;

## Creating the environment

Navigate to 2-Kubernetes directory;

Run the command ```k3d cluster list``` for verify if you have an cluster created on your localhost;

Next step is run the command ```k3d cluster create test --servers 3 --agents 3``` to create a High Availablity Cluster;

Next step is run the command ```kubectl cluster-info``` for obtain all information about the cluster;

Next step is run the command ```kubectl get nodes``` for verify each node and your role;

Next step is run the command ```docker container ls``` for verify all containers that you have been created before;

Next step is run the command ```kubectl apply -f DeploymentTest.yaml``` for deploy this deployment settings;

Next step is run the command ```kubectl get pods``` for get pods information output;

We gonna delete the DeploymentTest and configure a replica set for this;

Run the command ```kubectl delete -f DeploymentTest.yaml``` to take this remove procedure;

## Creating a Replica Set for Kubernetes Containers

Now, we can create a replica set configuration for our cluster, following this steps:

Run the command ```kubectl apply -f replicaset.yaml```

Next step is run the command ```kubectl get replicaset``` and after, run ```kubectl get pods``` for check if our deployment finished with success;

## Scaling the App Envinroment

Now, we can set the Replica Set for 5, let's do it

Run the command ```kubectl scale replicaset meureplicaset --replicas 5```;

After, run the command ```kubectl get pods``` for verify if the scaling occurs without errors;

And for finish, run the command ```kubectl get pods``` and you can see all 5 instances running on the cluster;