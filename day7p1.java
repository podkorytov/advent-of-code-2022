import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

class File {
    String name = "";
    int size = 0;

    public File(String n, int s) {
        name = n;
        size = s;
    }
}

class Dir {
    String name = "";
    Dir parent;
    List<Dir> subdirs;
    List<File> files;

    public Dir(String dirName, Dir p) {
        subdirs = new ArrayList<Dir>();
        files = new ArrayList<File>();
        name = dirName;
        parent = p;
    }

    public int getSize() {
        int result = 0;
        for (File file : files) {
            result += file.size;
        }
        for (Dir dir : subdirs) {
            result += dir.getSize();
        }

        return result;
    }

    public Dir getChild(String dirName) {
        for (Dir dir : subdirs) {
            if (dir.name.equals(dirName)) {
                return dir;
            }
        }
        return null;
    }

    public void print(String prefix) {
        for (Dir dir : subdirs) {
            System.out.println(prefix + "|_" + dir.name);
            dir.print(" " + prefix);
        }
        for (File file : files) {
            System.out.println(prefix + "." + file.name + " (" + file.size + ")");
        }
    }

    public int sumDirsWithLimit(int limit) {
        var out = 0;
        int size = getSize();
        if (size <= limit) {
            out += size;
        }
        for (Dir dir : subdirs) {
            out += dir.sumDirsWithLimit(limit);
        }
        return out;
    }
}

public class day7p1 {
    public static void main(String args[]) {
        BufferedReader reader;
        Dir mainDir = new Dir("/", null);
        Dir curDir = mainDir;

        try {
            reader = new BufferedReader(new FileReader("inputs/input_day7.txt"));
            String line = reader.readLine();

            while (line != null) {
                if (line.startsWith("$")) {
                    String[] parts = line.split(" ");
                    if (parts[1].equals("cd")) {
                        if (parts[2].equals("/")) {
                            curDir = mainDir;
                        } else if (parts[2].equals("..")) {
                            curDir = curDir.parent;
                        } else {
                            curDir = curDir.getChild(parts[2]);
                        }
                    }
                } else {
                    String[] parts = line.split(" ");
                    if (parts[0].equals("dir")) {
                        Dir newDir = new Dir(parts[1], curDir);
                        curDir.subdirs.add(newDir);
                    } else {
                        File newFile = new File(parts[1], Integer.parseInt(parts[0]));
                        curDir.files.add(newFile);
                    }
                }
                // read next line
                line = reader.readLine();
            }

            reader.close();
            System.out.println(mainDir.sumDirsWithLimit(100000));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}