{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_lab01 (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/andrei/.cabal/bin"
libdir     = "/Users/andrei/.cabal/lib/x86_64-osx-ghc-8.10.7/lab01-0.1.0.0-inplace-source-library"
dynlibdir  = "/Users/andrei/.cabal/lib/x86_64-osx-ghc-8.10.7"
datadir    = "/Users/andrei/.cabal/share/x86_64-osx-ghc-8.10.7/lab01-0.1.0.0"
libexecdir = "/Users/andrei/.cabal/libexec/x86_64-osx-ghc-8.10.7/lab01-0.1.0.0"
sysconfdir = "/Users/andrei/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "lab01_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "lab01_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "lab01_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "lab01_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "lab01_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "lab01_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
