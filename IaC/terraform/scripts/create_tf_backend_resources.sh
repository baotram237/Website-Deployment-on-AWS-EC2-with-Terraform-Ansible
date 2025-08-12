set -e  # Exit on error

BUCKET_NAME=state-bucket-dev-tramntb
REGION=ap-northeast-1

if [ -z "$BUCKET_NAME" ] || [ -z "$REGION" ]; then
  echo "Usage: $0 <bucket-name> <aws-region>"
  exit 1
fi

echo "🔹 Creating S3 bucket: $BUCKET_NAME in $REGION"

# Create bucket
aws s3api create-bucket \
  --bucket "$BUCKET_NAME" \
  --region "$REGION" \
  --create-bucket-configuration LocationConstraint="$REGION" \
  --acl private

echo "✅ Bucket created."

# Enable versioning
aws s3api put-bucket-versioning \
  --bucket "$BUCKET_NAME" \
  --versioning-configuration Status=Enabled
echo "✅ Versioning enabled."

# Enable server-side encryption (AES-256)
aws s3api put-bucket-encryption \
  --bucket "$BUCKET_NAME" \
  --server-side-encryption-configuration '{
    "Rules": [
      {
        "ApplyServerSideEncryptionByDefault": { "SSEAlgorithm": "AES256" }
      }
    ]
  }'
echo "✅ Default encryption enabled (AES-256)."

echo "🎯 S3 bucket '$BUCKET_NAME' is ready for Terraform backend."


# Create DynamoDB table for state locking
DYNAMODB_TABLE=terraform-locks-dev-tramntb
REGION=ap-northeast-1

echo "🔹 Creating DynamoDB table: $DYNAMODB_TABLE"

aws dynamodb create-table \
  --table-name "$DYNAMODB_TABLE" \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region "$REGION"

echo "✅ DynamoDB table created."
