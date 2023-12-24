# Cluster
In aws console create new cluster and node group 


# In project folder
aws eks --region us-east-1 update-kubeconfig --name cluster
helm repo add repo https://charts.bitnami.com/bitnami
helm repo update
helm install service repo/postgresql --set primary.persistence.enabled=false


# In /db folder
export POSTGRES_PASSWORD=$(kubectl get secret service-postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)
echo $POSTGRES_PASSWORD
kubectl port-forward svc/service-postgresql 5434:5432 &
PGPASSWORD="$POSTGRES_PASSWORD" psql -U postgres -d postgres -h 127.0.0.1 -p 5434 -a -f 1_create_tables.sql
PGPASSWORD="$POSTGRES_PASSWORD" psql -U postgres -d postgres -h 127.0.0.1 -p 5434 -a -f 2_seed_users.sql
PGPASSWORD="$POSTGRES_PASSWORD" psql -U postgres -d postgres -h 127.0.0.1 -p 5434 -a -f 3_seed_tokens.sql


# Create table and run seed data in /analytics folder
pip install -r requirements.txt
kubectl port-forward svc/service-postgresql 5434:5432 &
export DB_HOST=127.0.0.1
echo $DB_HOST
export DB_PORT=5434
echo $DB_PORT
export DB_NAME=postgres
echo $DB_NAME
DB_USERNAME=postgres DB_PASSWORD=qmApr4gJX3 python app.py
# Open another bash hear to run these command
    curl http://127.0.0.1:5153/api/reports/daily_usage
    curl http://127.0.0.1:5153/api/reports/user_visits


# In project folder
kubectl apply -f deployment/


# Usefull command
helm list
helm uninstall <<name>>
kubectl logs <<pod-name>>
kubectl delete deployment <<name>>

# NOTE: CREATE TABLE AND RUN SEED DATA AGAIN WHEN SESSION EXPIRED!!!