echo "Hello From Script"
yq '.secrets.read_access[]' secrets-config.yaml | while read -r secret_name; do
  role_to_attach="roles/secretmanager.secretAccessor"
  echo "Binding $role_to_attach for $secret_name"
  gcloud secrets add-iam-policy-binding projects/bhdigital-data-dev/secrets/$secret_name \
  --member "serviceAccount:test-iam-conditions@bhdigital-data-dev.iam.gserviceaccount.com" \
  --role $role_to_attach
done

yq '.secrets.write_access[]' secrets-config.yaml | while read -r secret_name; do
  role_to_attach="roles/secretmanager.secretVersionManager"
  echo "Binding $role_to_attach for $secret_name" 
  gcloud secrets add-iam-policy-binding projects/bhdigital-data-dev/secrets/$secret_name \
  --member "serviceAccount:test-iam-conditions@bhdigital-data-dev.iam.gserviceaccount.com" \
  --role $role_to_attach
done