def buildClosure = {}

def buildParameterMap = [:]
buildParameterMap['appName'] = 'ops-elasticsearch-maintenance'
buildParameterMap['buildClosure'] = buildClosure
buildParameterMap['deploymentStrategy'] = [
    "master": ["promote:test-ops"]
]

buildAndDeployGeneric(buildParameterMap)
