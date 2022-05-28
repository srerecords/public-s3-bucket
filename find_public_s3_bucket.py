import boto3


def handler(event, context):
    s3 = boto3.resource('s3')
    
    print("PUBLIC BUCKETS:")

    for bucket in s3.buckets.all():
        for grant in s3.BucketAcl(bucket.name).grants:
            if grant['Grantee']['Type'] == 'Group' and grant['Grantee']['URI'] == 'http://acs.amazonaws.com/groups/global/AllUsers':
                print(bucket.name)


