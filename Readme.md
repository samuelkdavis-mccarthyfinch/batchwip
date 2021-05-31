Todo:

Add sqs dead letter queue
Set up iam role for failed deliveries


Things to consider:
Lambda timeout (15 mins)
sqs -> lambda retries
sqs queue visibility timeout
sns retry delays
sns retry number
sns retry algorithm
sqs max retention (1 day)
should we create success/failure *something* for sns
