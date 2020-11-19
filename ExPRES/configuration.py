
import json
from jsonschema import validate as validate_schema
from jsonschema.exceptions import ValidationError
from .schema import SCHEMA, schema_uri_from_version
from .version import VERSION

class ExPRESConfig:

    def __init__(self, expres_config_data=None):
        self.config = expres_config_data
        self.error = None

    @property
    def config(self):
        return self._config

    @config.setter
    def config(self, config_data):
        json_schema = SCHEMA.get('$schema', schema_uri_from_version(VERSION))

        try:
            validate_schema(instance=config_data, schema=json_schema)
        except ValidationError as error:
            self.error = error
        self._config = config_data

    @classmethod
    def from_json(cls, expres_config_file):
        with open(expres_config_file, 'r') as f:
            expres_config_data = json.loads(f.read())
        return cls(expres_config_data)