# coding=UTF-8
from distutils.sysconfig import get_python_inc
import platform
import os
import subprocess
import ycm_core
from os.path import expanduser

#获取根目录即/homelinchen
HOME_PATH = os.environ['HOME']

DIR_OF_THIS_SCRIPT = os.path.abspath( os.path.dirname( __file__ ) )
DIR_OF_THIRD_PARTY = os.path.join( DIR_OF_THIS_SCRIPT, 'third_party' )
SOURCE_EXTENSIONS = [ '.cpp', '.cxx', '.cc', '.c', '.m', '.mm' ]

# These are the compilation flags that will be used in case there's no
# compilation database set (by default, one is not set).
# CHANGE THIS LIST OF FLAGS. YES, THIS IS THE DROID YOU HAVE BEEN LOOKING FOR.
flags = [
'-std=c++11',
'-Wall',
'-Wextra',
'-Werror',
'-Wno-long-long',
'-Wno-variadic-macros',
'-fexceptions',
'-DNDEBUG',
# You 100% do NOT need -DUSE_CLANG_COMPLETER and/or -DYCM_EXPORT in your flags;
# only the YCM source code needs it.
'-DUSE_CLANG_COMPLETER',
'-DYCM_EXPORT=',
# THIS IS IMPORTANT! Without the '-x' flag, Clang won't know which language to
# use when compiling headers. So it will guess. Badly. So C++ headers will be
# compiled as C headers. You don't want that so ALWAYS specify the '-x' flag.
# For a C project, you would set this to 'c' instead of 'c++'.
'-x',
'c++',
'isystem',
'/usr/include/c++/7.3.0'
'-isystem',
'/usr/include',
'-isystem',
'/usr/local/include',
'-isystem',
HOME_PATH+'/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/pybind11',
'-isystem',
HOME_PATH+'/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/BoostParts',
'-isystem',
get_python_inc(),
'-isystem',
HOME_PATH+'/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/llvm/include',
'-isystem',
HOME_PATH+'/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/llvm/tools/clang/include',
'-I',
HOME_PATH+'/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm',
'-I',
HOME_PATH+'/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/ClangCompleter',
'-isystem',
'cpp/ycm/tests/gmock/gtest',
'-isystem',
HOME_PATH+'/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/tests/gmock/gtest/include',
'-isystem',
HOME_PATH+'/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/tests/gmock',
'-isystem',
HOME_PATH+'/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/tests/gmock/include',
'-isystem',
HOME_PATH+'/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/benchmarks/benchmark/include',
'-isystem,',
'/usr/include/GL',
'-I',
'.'
]

# Clang automatically sets the '-std=' flag to 'c++14' for MSVC 2015 or later,
# which is required for compiling the standard library, and to 'c++11' for older
# versions.
if platform.system() != 'Windows':
  flags.append( '-std=c++11' )


# Set this to the absolute path to the folder (NOT the file!) containing the
# compile_commands.json file to use that instead of 'flags'. See here for
# more details: http://clang.llvm.org/docs/JSONCompilationDatabase.html
#
# You can get CMake to generate this file for you by adding:
#   set( CMAKE_EXPORT_COMPILE_COMMANDS 1 )
# to your CMakeLists.txt file.
#
# Most projects will NOT need to set this to anything; you can just change the
# 'flags' list of compilation flags. Notice that YCM itself uses that approach.
compilation_database_folder = ''


if os.path.exists( compilation_database_folder ):
  database = ycm_core.CompilationDatabase( compilation_database_folder )
else:
  database = None

SOURCE_EXTENSIONS = [ '.cpp', '.cxx', '.cc', '.c', '.m', '.mm' ]

def DirectoryOfThisScript():
  return os.path.dirname( os.path.abspath( __file__ ) )


def MakeRelativePathsInFlagsAbsolute( flags, working_directory ):
  if not working_directory:
    return list( flags )
  new_flags = []
  make_next_absolute = False
  path_flags = [ '-isystem', '-I', '-iquote', '--sysroot=' ]
  for flag in flags:
    new_flag = flag

    if make_next_absolute:
      make_next_absolute = False
      if not flag.startswith( '/' ):
        new_flag = os.path.join( working_directory, flag )

    for path_flag in path_flags:
      if flag == path_flag:
        make_next_absolute = True
        break

      if flag.startswith( path_flag ):
        path = flag[ len( path_flag ): ]
        new_flag = path_flag + os.path.join( working_directory, path )
        break

    if new_flag:
      new_flags.append( new_flag )
  return new_flags


def IsHeaderFile( filename ):
  extension = os.path.splitext( filename )[ 1 ]
  return extension in [ '.h', '.hxx', '.hpp', '.hh' ]


def GetCompilationInfoForFile( filename ):
  # The compilation_commands.json file generated by CMake does not have entries
  # for header files. So we do our best by asking the db for flags for a
  # corresponding source file, if any. If one exists, the flags for that file
  # should be good enough.
  if IsHeaderFile( filename ):
    basename = os.path.splitext( filename )[ 0 ]
    for extension in SOURCE_EXTENSIONS:
      replacement_file = basename + extension
      if os.path.exists( replacement_file ):
        compilation_info = database.GetCompilationInfoForFile(
          replacement_file )
        if compilation_info.compiler_flags_:
          return compilation_info
    return None
  return database.GetCompilationInfoForFile( filename )


def FlagsForFile( filename, **kwargs ):
  if database:
    # Bear in mind that compilation_info.compiler_flags_ does NOT return a
    # python list, but a "list-like" StringVec object
    compilation_info = GetCompilationInfoForFile( filename )
    if not compilation_info:
      relative_to = DirectoryOfThisScript()
      return {
        'flags': MakeRelativePathsInFlagsAbsolute( flags, relative_to ),
        'do_cache': True
      }

    final_flags = MakeRelativePathsInFlagsAbsolute(
      compilation_info.compiler_flags_,
      compilation_info.compiler_working_dir_ )

  else:
    relative_to = DirectoryOfThisScript()
    final_flags = MakeRelativePathsInFlagsAbsolute( flags, relative_to )

  return {
    'flags': final_flags,
    'do_cache': True
  }
