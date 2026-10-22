import os

import boto3
from botocore.exceptions import BotoCoreError, ClientError
from flask import Flask, jsonify, render_template

app = Flask(__name__)

floci_endpoint = os.environ.get("FLOCI_ENDPOINT_URL", "http://localhost:4566")
expected_bucket = os.environ.get(
    "EXPECTED_S3_BUCKET", "minicurso-opentofu-migrado"
)
s3 = boto3.client(
    "s3",
    endpoint_url=floci_endpoint,
    region_name=os.environ.get("AWS_DEFAULT_REGION", "us-east-1"),
    aws_access_key_id=os.environ.get("AWS_ACCESS_KEY_ID", "test"),
    aws_secret_access_key=os.environ.get("AWS_SECRET_ACCESS_KEY", "test"),
)


@app.get("/")
def index():
    return render_template("index.html", endpoint=floci_endpoint)


@app.get("/health")
def health():
    return {"status": "ok"}


@app.get("/api/status")
def status():
    try:
        response = s3.list_buckets()
    except (BotoCoreError, ClientError) as error:
        app.logger.warning("Não foi possível consultar o Floci: %s", error)
        return (
            jsonify(
                connected=False,
                endpoint=floci_endpoint,
                expected_bucket=expected_bucket,
                error=str(error),
            ),
            503,
        )

    buckets = sorted(bucket["Name"] for bucket in response.get("Buckets", []))
    return jsonify(
        connected=True,
        endpoint=floci_endpoint,
        expected_bucket=expected_bucket,
        bucket_provisioned=expected_bucket in buckets,
        buckets=buckets,
    )


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
