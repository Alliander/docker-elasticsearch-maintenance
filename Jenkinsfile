def buildClosure = {}

def buildParameterMap = [:]
buildParameterMap['appName'] = 'ops-elasticsearch-maintenance'
buildParameterMap['buildClosure'] = buildClosure
buildParameterMap['deploymentStrategy'] = [
    "master": ["promote:" + env.NAMESPACE_OPS]
]

buildAndDeployGeneric(buildParameterMap)
