% Функция расчета кратчайшего расстояние от указанного узла
% Загрузка поверхности, связей и стартового узла
% Face - номер вешины либо ее координаты
function [mesh_distance] = meshm_dist(mesh,Face)
    tic
    Faces=mesh.Faces;
    Vertices=mesh.Vertices;
    VertConn=tess_vertconn(Vertices,Faces);
    % VertNormals = tess_normals(Vertices, Faces, VertConn);
    nv = size(Vertices,1);
    face=find_nearest_face(Face,Vertices,nv);
    mesh_distance = distance_count( face, Vertices, VertConn, nv);
    toc
end

% Функция расчета кратчайшего расстояние от указанного узла
% mesh_distance-расстояния до всех вершин, face-стартовая вершина, 
% Faces-повехность коры(убрал как неиспользуемую), Vertices-массив вершин, VertConn-связи вершин,
% nv - число вершины

function [mesh_distance] = distance_count(face, Vertices, VertConn, nv) 
        VertConnGrow = zeros(1,nv);
        VertConnGrow(face)=1;
        mesh_distance=zeros(1,nv);
        Iter=0;
        while 1
            Iter=Iter+1;
            VertConnPrev = VertConnGrow;
            VertConnGrow = double(VertConnGrow * VertConn > 0);
            if Iter>1
            VertConnGrow(find(mesh_distance>0))=0;
            end
            VertConnGrow(face)=0;
            vind = find(VertConnGrow - VertConnPrev > 0);
            for i=1:length(vind)
                mesh_distance(vind(i))=0;
                        vold=find(VertConnPrev > 0);
                        if Iter>1
                        
                            PrevConn=find(VertConn(vold,vind(i)));
                                mesh_distance(vind(i))=sqrt((Vertices(vold(PrevConn(1)),1) - Vertices(vind(i),1)).^2 + (Vertices(vold(PrevConn(1)),2) - Vertices(vind(i),2)).^2 + (Vertices(vold(PrevConn(1)),3) - Vertices(vind(i),3)).^2)+mesh_distance(vold(PrevConn(1)));

                                continue;
                        else
                            mesh_distance(vind(i))=sqrt((Vertices(face,1) - Vertices(vind(i),1)).^2 + (Vertices(face,2) - Vertices(vind(i),2)).^2 + (Vertices(face,3) - Vertices(vind(i),3)).^2);                    
                        end
                    end

            if Iter>2
                if numel(find(mesh_distance)>0)==ndist||numel(find(mesh_distance)>0)==nv-1
                break;
                end
            end
            if Iter>1
                ndist=numel(find(mesh_distance)>0);
            end
        end
end

function [face]=find_nearest_face(Face,Vertices,nv)

if size(Face,2)==3
    parfor i=1:nv
        d(i)=sqrt((Vertices(i,1) - Face(1)).^2 + (Vertices(i,2) - Face(2)).^2 + (Vertices(i,3) - Face(3)).^2);
        
    end
    face=find(d==min(d));
    disp(strcat('Initial face is #',num2str(face)));
else
    face=Face;
end
end