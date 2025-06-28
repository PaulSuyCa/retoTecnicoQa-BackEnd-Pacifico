function fn() {
  var env = karate.env;
  karate.log('karate.env system property was:', env);
  var baseUrl = ''
  var dataPath = ''

  if (!env) {
    // configuracion por default
    env = 'dev';
  }

  if (env === 'dev') {
    baseServerUsuarios = 'https://serverest.dev'
    dataPath = 'Desarrollo'
  } else if (env === 'cert') {
    baseServerUsuarios = 'https://serverest.dev'
    dataPath = 'Certificacion'
  }

  var config = { // configuracion base JSON
    env: env,
    baseServerUsuarios: baseServerUsuarios,
    dataPath: dataPath
  };

  // No pierda el tiempo esperando una conexión o si los servidores no responden en 5 segundos.
  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);
  return config;
}