##############################
# inventory-quarkus Solution #
##############################

DIRECTORY=`dirname $0`

$DIRECTORY/solve.sh

cd ${CHE_PROJECTS_ROOT}/inventory/labs/inventory-quarkus
mvn clean package -DskipTests

cd ${CHE_PROJECTS_ROOT}/inventory
odo delete --all --force
odo project set my-project${CHE_WORKSPACE_NAMESPACE#user}
odo create java:11 inventory --binary labs/inventory-quarkus/target/inventory-quarkus-1.0.0-SNAPSHOT-runner.jar --s2i --app coolstore
odo push
odo url create inventory --port 8080
odo push

oc label dc inventory-coolstore app.openshift.io/runtime=quarkus --overwrite

echo "Inventory Quarkus Deployed"