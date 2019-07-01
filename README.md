# Central Heating System

## API Instructions
Headers for APIs:

```
Authorization: generated_household_token
Content-Type: application/json
```

### APIs:

#### Post Reading:

POST /api/v1/readings

*Sample request payload*

```
{
  "reading": {
    "temperature": 24.5,
    "humidity": 34.5,
    "battery_charge": 54.5
  }
}
```

#### Get Reading

GET /api/v1/readings/{{reading_id}}

#### Get Stats

GET /api/v1/stats


## Testing

### Step 1:

Run the below command for test environment DB migrations

```
RAILS_ENV=test rake db:drop db:create db:migrate
```

### Step 2:

Execute Specs by running rspec like below,

```
rspec
```


